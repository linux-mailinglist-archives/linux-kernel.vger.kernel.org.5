Return-Path: <linux-kernel+bounces-122061-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 26D6088F162
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 22:55:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 57B731C2D3A1
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 21:55:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF79D15359D;
	Wed, 27 Mar 2024 21:55:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AzpC6ITk"
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BA85153572
	for <linux-kernel@vger.kernel.org>; Wed, 27 Mar 2024 21:55:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711576518; cv=none; b=skSiJIwQU6bRZy35yRdPYHSxPb91fVzcrOhEkSUsTtCoyD62pv2U1qCid8FR8GyZPjod26FXmQX7jbOvIzkmN9Xy0rwmmjc2UjefpN41MOJtq8/kXh7crm1hfyUWc6cq8+ndEGEJH7EG1/clR4v5o8wQEznX2vilvTZnuGyKB/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711576518; c=relaxed/simple;
	bh=PQVZZIRaKQhkJhUnG72lePTcQWJXDx/rUBRzSVF2ep0=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=X+GdIvUbv+4nmIvBUnLgJaSd4phcuKlYTQCdf+6UoKQjPBl+KRK1KpCwyFX/dGoV7QrRkUwq0GvL5HXdHsAoqbMN4whfmDjAF5fYNmJPw8UzGJQuMgwWCtT9hV/ikL8O6XgQqMsefQe/r4md2Pb8hIObxgvR9k1PbOCPDmx86PU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AzpC6ITk; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-341e36878b1so68323f8f.1
        for <linux-kernel@vger.kernel.org>; Wed, 27 Mar 2024 14:55:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711576515; x=1712181315; darn=vger.kernel.org;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dwdGycr3xucKOW798pZ9AEyP81jNbTl3Rfs7NX+nxEI=;
        b=AzpC6ITkzJhcbkjHS5MTAnZDW/sw7KKJno3k/nI6kC/7faLSA4Adr9VkvP1ZL6t2CI
         0e50cKunK4imJS0vsu/W5ghvHxxYou6s34Xer+OxCzRp5q4LolfQ4mbNCw/Gl+ATVo+H
         YMC33jlXKWl8BQ3YEq81EzR3+g7gxcGZjGDifdrxYxcJnBbI+7FMXEjgHiL1LwRtQvAB
         F6nfyEV6b4AkBgrF6Gq3MJvMtEszbMFqQMaQdLqTfZNVc27bEmKz6ibp1u3W6cxFCD2G
         kO8EB8Uu3tMz1Q5AagH368gt3FR23pafmiIFAJoAzACZNoMVTm15Tnp6EltjHcBaWq/g
         UrPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711576515; x=1712181315;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=dwdGycr3xucKOW798pZ9AEyP81jNbTl3Rfs7NX+nxEI=;
        b=jRAKLHEhnCQqdIf/czlDTACCgWddVsbEBz8c3ldPHnP/xBj9RBHB0gh4b7YrwnYCL0
         SJwdtow6Ys9CEYbVTZ8iHtZHYU7nXq78U8butwYHUVkN3ydjjYWerjJDlMjLxUaVSVCp
         QM8Fvuidffby696We82Vt8tBsqr3bZbhut33rlaTt5K2K2vTWcIyq3y+2+LZpZpOJ1KA
         mYRlUbYvSUDRRQTAnjeFWCZpjS6/eKU/pWp+H9+ZShZDaGn18xoC45l6maSLgTg9j1fG
         mrSYL7oOq+1TrvsTiZZzY4obBdX4wjWV0qM+L2w0M8Wc8lnZrWixIAIVExeMc2KN30Up
         6arQ==
X-Forwarded-Encrypted: i=1; AJvYcCVfJ9FQrmz0TK374MLkPDzrrJ8y0w3WPXPKx/e1ChQd8rbI4r11eGx2GQzXrys1tYAzv+H9ofbUH1E0OZYscPQSt+75LoqLI69f+7Fj
X-Gm-Message-State: AOJu0Yxuze6gwp4XjYPV6uqYBTd7jlHG9Y814TRjlam5q6ZKSL8yPm78
	qMxNYvEhT/tGpxjHKAEE+Rlr9sCH8lw3V/q+Y7W6JbQVN9+6CelP
X-Google-Smtp-Source: AGHT+IGccx9eaqBykQEYnZT3gkwcYJOSo1MsJiwoqilAQjnT5wLYFwDyTWEjzvUpPLXhEszbj19qmQ==
X-Received: by 2002:a05:600c:1c21:b0:414:8554:73e with SMTP id j33-20020a05600c1c2100b004148554073emr992027wms.1.1711576514811;
        Wed, 27 Mar 2024 14:55:14 -0700 (PDT)
Received: from [192.168.0.104] (p54a07fa0.dip0.t-ipconnect.de. [84.160.127.160])
        by smtp.gmail.com with ESMTPSA id h9-20020a05600c314900b004147b824b08sm192228wmo.7.2024.03.27.14.55.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 27 Mar 2024 14:55:14 -0700 (PDT)
Message-ID: <c4c5ab38-8c67-4c21-86bc-f4f3c06be358@gmail.com>
Date: Wed, 27 Mar 2024 22:55:13 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Marcus Wolf <linux@wolf-entwicklungen.de>,
 Marcus Wolf <marcus.wolf@wolf-entwicklungen.de>,
 "linux-staging@lists.linux.dev" <linux-staging@lists.linux.dev>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc: Dan Carpenter <dan.carpenter@linaro.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
From: Philipp Hortmann <philipp.g.hortmann@gmail.com>
Subject: [RFC] staging: pi433: Proposal to remove unused driver
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Marcus,

according to this homepage:
https://www.kickstarter.com/projects/1292669042/pi433-a-radio-module-funkmodul-for-raspberry-pi
you had a group of people to test and use the Pi433. But last 
update/comments on this website are from November 21, 2017. What 
happened afterwards? Did you organize the community differently?

On this homepage:
https://www.pi433.de/en.html
you wrote:
"Purchase Pi433
Due to the rules for recycling (WEEE guideline of EU) Smarthome-Wolf 
decided to stop the direct distribution of Pi433.

Business partner (e. g. online stores for selling Raspberry-Pi 
accessories), interested in distribution of Pi433 are very welcome!"

It seems that this was also in 2017

Did you manage to find a business partner?
How many devices have been sold after 2017? Are there people who got 
more than 1 device?

Please respond to avoid that unused code stays in the mainline kernel 
forever.

Thanks for your support.

Bye Philipp

