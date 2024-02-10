Return-Path: <linux-kernel+bounces-60367-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A3968850411
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Feb 2024 12:01:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 08D5B1F23F6C
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Feb 2024 11:01:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD023364CF;
	Sat, 10 Feb 2024 11:01:03 +0000 (UTC)
Received: from mail3-162.sinamail.sina.com.cn (mail3-162.sinamail.sina.com.cn [202.108.3.162])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D7A0259B
	for <linux-kernel@vger.kernel.org>; Sat, 10 Feb 2024 11:00:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.108.3.162
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707562863; cv=none; b=DAE+jB2JdSl8PVfDEyIxXyroeGqD30aLVQoQK8+Ma3y2tuQ16KFk6boGDHFWWQBMy2PYWacemnr1Q/FlU3pBbvdNQ793p51aviNR5vcTYwQ91Cr3x2lrQiYcrS7nns0o0BIwtzY/OYodYbQ2XOB+tlPQyU7aoAZ9WbTBWuKkt4s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707562863; c=relaxed/simple;
	bh=cf5+1fQkMr7nWT21y+6t9ZWJSbi3v7BBMchlk6Kc5Jk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mbHiioh5m5WQ21Lso+aMxBplT0qkTCF+RoXazEhB9G4mvXysBbBNaZSEkYysShJfQiC+KW6fwUuGP5CtN7wGrg5zkt+LR5EuaV8vZkcytqnYOpZBNrpMZb//iHj77U4BN0aiznZPIu3Qb5A97H4kXHxTVXelM28xF7fVqZAu+Yc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com; spf=pass smtp.mailfrom=sina.com; arc=none smtp.client-ip=202.108.3.162
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sina.com
X-SMAIL-HELO: localhost.localdomain
Received: from unknown (HELO localhost.localdomain)([114.249.59.61])
	by sina.com (10.182.253.22) with ESMTP
	id 65C7576500007D89; Sat, 10 Feb 2024 19:00:55 +0800 (CST)
X-Sender: hdanton@sina.com
X-Auth-ID: hdanton@sina.com
Authentication-Results: sina.com;
	 spf=none smtp.mailfrom=hdanton@sina.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=hdanton@sina.com
X-SMAIL-MID: 7566756816312
X-SMAIL-UIID: AD44519A6EF44531B70A437BDDCF86FD-20240210-190055-1
From: Hillf Danton <hdanton@sina.com>
To: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Linus Walleij <linus.walleij@linaro.org>,
	"Paul E . McKenney" <paulmck@kernel.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Wolfram Sang <wsa@the-dreams.de>,
	linux-gpio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: Re: [PATCH v3 01/24] gpio: protect the list of GPIO devices with SRCU
Date: Sat, 10 Feb 2024 19:00:41 +0800
Message-ID: <20240210110043.853-1-hdanton@sina.com>
In-Reply-To: <20240208095920.8035-2-brgl@bgdev.pl>
References: <20240208095920.8035-1-brgl@bgdev.pl>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Thu,  8 Feb 2024 10:58:57 +0100 Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> @@ -382,11 +389,13 @@ static int gpiodev_add_to_list_unlocked(struct gpio_device *gdev)
>  		/* add between prev and next */
>  		if (prev->base + prev->ngpio <= gdev->base
>  				&& gdev->base + gdev->ngpio <= next->base) {
> -			list_add(&gdev->list, &prev->list);
> +			list_add_rcu(&gdev->list, &prev->list);
>  			return 0;
>  		}
>  	}
>  
> +	synchronize_srcu(&gpio_devices_srcu);
> +
If not typo, could you shed light on why this sync is needed?

>  	return -EBUSY;
>  }

