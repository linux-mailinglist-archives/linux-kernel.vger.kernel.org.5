Return-Path: <linux-kernel+bounces-160333-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A84EC8B3C13
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 17:53:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D9CCDB230E8
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 15:53:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B2BA14A4D4;
	Fri, 26 Apr 2024 15:53:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cS+bGTdF"
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD3C11DFFC
	for <linux-kernel@vger.kernel.org>; Fri, 26 Apr 2024 15:53:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714146798; cv=none; b=K1OxcYLoIGH8FTqQ1a4mJWBSZ2cAZERUTDBYZNbTeP34UWQVmxZwkQgAq8/wX9ctlidaZdRFSfp2zH0GPXH31duGI2/V4zx3U148HTkgT/VYxeHbBGUiVOOzKOf47xK+y4nEfs+NFDsnpqM0S/4FKHffkKpsOm/caJF1WtDqH14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714146798; c=relaxed/simple;
	bh=IYCeyfV7+Y22lbEJ698coh+qx6ohE4k19gQwII2/pLY=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=YOf1p+Tl47PE8iuZrLVUMSuAOY1FWDB51alSbEsllVscvnYmtzE/A9GThS5F+/GJR3AN3P+QAAF92t8VWXTqQv79lyeIH0LhgMMIDsWUMSHVCaHAzOnLjZcGkTY4n1z7xy4YS6OgbSRgQimqgs9VE6+U3pNeUZm24kHeCQdzpQs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cS+bGTdF; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-516d1ecaf25so3166292e87.2
        for <linux-kernel@vger.kernel.org>; Fri, 26 Apr 2024 08:53:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714146795; x=1714751595; darn=vger.kernel.org;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XwyPHYo65laLUVyoAnrn3i4ckDikcCisySrk/yWvbuM=;
        b=cS+bGTdFcF9s/5r1CvOskBMwP6JNBpnoxO0yAbskjIxBLLzM2RtsrcVGy+RwUSakQF
         ZGsG8QcHsJXykvq3ZcxNX7wd0hLHGcIRUEF0CWqmyPfHUrzqsfXeXCzb+lGQQtwWA/DB
         uXscx+XVLVOL58esA8SfvZyTAOKR4Q6pz5t49t410uBdK3TDQqJvO0j/V2YXf4Ko94fI
         A1n6eAatumb0Z7EyfVcavYunShkNn7a+mGm11Bm9qEVWRBx2nuU0lxd55a9Njkb5gqL5
         R/VtQPzBaNk3/WB1jJUB+ufINF/ws7JALMlOIA4tmNOEohkw97Qs5/EZdSQtIO6eEYnH
         237Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714146795; x=1714751595;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=XwyPHYo65laLUVyoAnrn3i4ckDikcCisySrk/yWvbuM=;
        b=XSYsSD12kKk4jAulOTqn+uzEbZhpqPB2H5x4q1EnljkuWLyiWNrlNRPoJ7Zq6h/3Oo
         kLTXFJAWgr6uuBh8PUg1tz0Au5p/1S6gEoR3VTrN8HlS0NZTH4JdwLVxn2IDUnPbRN+m
         Iiyh7F354CGRLxhwu+HvfDv1Vi5/igV9+y00pIPMj4jhbSqdvkgSWJqqifwgEKpKqoOQ
         JxO4w1z7THfidrkzKUnZeyNTBLcYKkJMsDqzdyV3MZcdHa0RJqbuiQBPW/c4TIRr8pfR
         CRWt+/cn+s8m3RcY3rb/IrnNz0OFFzPfYcGKzbDfz0RD3C7nPScnAR89u1zFnGE5ECBw
         CfFw==
X-Gm-Message-State: AOJu0Yy3YjWywtlzkmMtfaY98ZNCp7zevmTkbb+b33p099PCRBMQRUW/
	ip9mQoN+eBSPFII85QxtknHJPZyUvP3n8q9n2nfraRV/xtGkOfioEiZ2yQ==
X-Google-Smtp-Source: AGHT+IG3ZYjK5XuwSZGbYiI5HmuraJR99briOvmc5X0RLDSRQhbEQLu+YP75d5Nf0c+mLz+VDLVzpA==
X-Received: by 2002:ac2:5b8b:0:b0:51c:f00c:2243 with SMTP id o11-20020ac25b8b000000b0051cf00c2243mr400492lfn.35.1714146794767;
        Fri, 26 Apr 2024 08:53:14 -0700 (PDT)
Received: from ?IPV6:2003:df:bf00:9700:9056:af48:9a78:e564? (p200300dfbf0097009056af489a78e564.dip0.t-ipconnect.de. [2003:df:bf00:9700:9056:af48:9a78:e564])
        by smtp.gmail.com with ESMTPSA id cf5-20020a170906b2c500b00a587868c5d2sm4737566ejb.195.2024.04.26.08.53.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 26 Apr 2024 08:53:14 -0700 (PDT)
Message-ID: <1b409e15-7f9a-4e07-bacb-14f71a4bb671@gmail.com>
Date: Fri, 26 Apr 2024 17:53:13 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: de-AT-frami, en-US
To: Linux kernel mailing list <linux-kernel@vger.kernel.org>
Cc: Dirk Behme <dirk.behme@de.bosch.com>
From: Dirk Behme <dirk.behme@gmail.com>
Subject: data-race in dev_uevent / really_probe?
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

debugging a NULL pointer crash on a quite old embedded system kernel 
(4.14.x) we might have found the root cause for

https://syzkaller.appspot.com/bug?extid=ffa8143439596313a85a
https://groups.google.com/g/syzkaller-upstream-moderation/c/xTpwi0C6eSY/m/FqJAQtinAQAJ

Looking at the recent kernel, it looks like the relevant code hasn't 
changed that much since then. So even in recent kernel code it looks 
like there is a synchronization issue between dev_uevent() and 
really_probe():

Thread #1:
========

really_probe() {
...
probe_failed:
...
device_unbind_cleanup(dev) {
      ...
      dev->driver = NULL;   // <= Failed probe sets dev->driver to NULL
      ...
      }
..
}

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/base/dd.c#n552


Thread #2:
========

dev_uevent() {
..
if (dev->driver)
                 // If dev->driver is NULLed from really_probe() from 
here on,
                 // after above check, the system crashes
		add_uevent_var(env, "DRIVER=%s", dev->driver->name);
..
}

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/base/core.c#n2670

The setup is a device driver probe that fails. In our case the probe 
from an I2C driver. While that failing probe does issue some 
dev_info() and dev_err() output. What seems to trigger in our case 
systemd-journal (as given in the groups.google.com link above) which 
calls via the given call stack dev_uevent().

In the end, dev_uevent() has validated dev->driver successfully. But 
if, depending on timing, exactly after this the failing 
(really-)probe() NULLs dev->driver, the system crashes due to using 
dev->driver being NULL then.

Does that make sense? Or have we missed anything?

Best regards

Dirk


