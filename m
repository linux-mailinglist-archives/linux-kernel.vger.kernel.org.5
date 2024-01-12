Return-Path: <linux-kernel+bounces-24181-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D256B82B8A6
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 01:38:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 70A2C1F25B08
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 00:38:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B35C3814;
	Fri, 12 Jan 2024 00:38:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Fl5uaKTB"
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCBD562D
	for <linux-kernel@vger.kernel.org>; Fri, 12 Jan 2024 00:38:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-6db05618c1fso3697410b3a.1
        for <linux-kernel@vger.kernel.org>; Thu, 11 Jan 2024 16:38:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1705019926; x=1705624726; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=JAK9KBXi33OtAdjiTl1d1gOMeWGfOdW5FgG0yThbQXc=;
        b=Fl5uaKTB+Le2qbp25gn6TuTnhBOOzqlZeJ4Y8PtgviganT1x9yCm6FMp3BYrJRUlYk
         gvxlUc7FmHHwOJbBP+M0iB+waWD5lyN6n61PeGBVKaQsGA+qe7JkCPYVIK4aejuhuK1Z
         y6XJDpOabup4Ol1bgJnR9ipolJDJiXcpu3xsM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705019926; x=1705624726;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JAK9KBXi33OtAdjiTl1d1gOMeWGfOdW5FgG0yThbQXc=;
        b=VCwZLkyeyFlVAdWQacGyUEqjCXPRgKk2uEOa90CnZD06Gplt2BJAYXlD7N8LV+Wtsa
         FFL52NSOG5oJ5OLmVE6V9+gZjaffU0PIqfBSKfIZCJpKwsb2j/+mCQahBwPkcuernMdM
         Evbju65PwtoxAmtePgHMyFcRzvQSSDiwRTAo/zv8Y/xg/pDHkftv+SP1m+hJ74TjmPrG
         ySvvJD/Cmjuw2Bigv+zychB+Y+WlLxvyt8LzvWL9wfSjEj1jJ8R4KFS6uycFFrL1ijqP
         j1i0p1n35T9Np1iWzEjeAWKAfoR8rmVrqQvHzrp4/sYebO0iZR94Im8u2NrD8OThgPig
         txeQ==
X-Gm-Message-State: AOJu0YzPYQq7OYxC4Rsic6c/F8bSxGFo/GtgstyXB/j8hppV7g0SGQCj
	HkEI3vSGCB1grT2COp35NZ+tSGjFePsa
X-Google-Smtp-Source: AGHT+IFjtpdSOunGRQEO+G9OUyBdAUTnQd+sia/HQzGg2yHiBwnsnkby6j6+R7Pb19wBS6Nz/vpVkQ==
X-Received: by 2002:a05:6a20:2505:b0:199:e425:daab with SMTP id j5-20020a056a20250500b00199e425daabmr194911pzd.6.1705019926122;
        Thu, 11 Jan 2024 16:38:46 -0800 (PST)
Received: from localhost ([2620:15c:9d:2:70e4:ce9:9cc2:b930])
        by smtp.gmail.com with UTF8SMTPSA id l18-20020a637012000000b005c65e82a0cbsm1829393pgc.17.2024.01.11.16.38.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 11 Jan 2024 16:38:45 -0800 (PST)
Date: Thu, 11 Jan 2024 16:38:44 -0800
From: Brian Norris <briannorris@chromium.org>
To: =?iso-8859-1?Q?N=EDcolas_F=2E_R=2E_A=2E?= Prado <nfraprado@collabora.com>
Cc: Tzung-Bi Shih <tzungbi@kernel.org>, kernel@collabora.com,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Julius Werner <jwerner@chromium.org>,
	chrome-platform@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/4] firmware: google: cbmem: Add to module device table
Message-ID: <ZaCKFCMop9lqWzxx@google.com>
References: <20240111151226.842603-1-nfraprado@collabora.com>
 <20240111151226.842603-4-nfraprado@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240111151226.842603-4-nfraprado@collabora.com>

On Thu, Jan 11, 2024 at 12:11:48PM -0300, Nícolas F. R. A. Prado wrote:
> Create an id table and add it to the module device table to allow the
> cbmem driver to be automatically loaded when a matching device is found.
> 
> Signed-off-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>

Might as well also patch framebuffer-coreboot.c and
memconsole-coreboot.c while you're at it?

But for this one:

Acked-by: Brian Norris <briannorris@chromium.org>

