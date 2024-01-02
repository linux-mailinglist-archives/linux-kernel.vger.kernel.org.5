Return-Path: <linux-kernel+bounces-14395-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D72B7821C79
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 14:19:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D64A61C22080
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 13:19:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 001EAFBE4;
	Tue,  2 Jan 2024 13:18:57 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-oo1-f51.google.com (mail-oo1-f51.google.com [209.85.161.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AD68F9E6;
	Tue,  2 Jan 2024 13:18:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f51.google.com with SMTP id 006d021491bc7-5958d3f2d8aso270136eaf.1;
        Tue, 02 Jan 2024 05:18:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704201534; x=1704806334;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1Z/aZekOHHjZPa6W+lRfUU70kAOn6yYoCT3d0V22B6s=;
        b=LnngeC/Ulg5L8H12/YVUsUM/qOxGeuv04apZmdLzImzt9MtQUU2UKon/ns3tKqMONF
         pjnxR9XybHo4wA8dXGJefzCWkzWDAg46lyLk+E0yX8qrxH5V+X2lnHv2gBLWP3PIEh9T
         loLamdecVU9lgQgu5graglljSmKOOLX8tySH0WzkHGWYKRZZikjMO6ZD/VBNsb8OhtGz
         v60euh1XItjkpoJP+a5HGPkCv60V4lwtD13U68q3SkWkXoebbxsGNUUxZpoHh9Wt/XZo
         O49VBuTiEIwKv98g0c4GCJiyf/A5U5P3m4dGHbQS54VavCVMBWvKNKndgxkKmOKUK/l/
         wxRQ==
X-Gm-Message-State: AOJu0YwWtECialLn6dzKAvP0Oo1DZckezqqVMPW87t5W5PByA22ks0Z/
	DyzPf7qpHbQkZXuPurDvt/+ppB7ARDG8i/H+wAGo4YVs
X-Google-Smtp-Source: AGHT+IHbWu7tF56Yvh8842MWCPhLy8fvp/UUcthGkkfA3I+BV2Bk0AeT9d8KQsJN4ahrUMpbPnhy7K2167sop+sBJ7g=
X-Received: by 2002:a4a:da55:0:b0:595:e0dd:9f8a with SMTP id
 f21-20020a4ada55000000b00595e0dd9f8amr1053638oou.1.1704201534446; Tue, 02 Jan
 2024 05:18:54 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CGME20231227084252epcas2p3b063f7852f81f82cd0a31afd7f404db4@epcas2p3.samsung.com>
 <2023122701-mortify-deed-4e66@gregkh> <5754861.DvuYhMxLoT@kreacher> <6019796.lOV4Wx5bFT@kreacher>
In-Reply-To: <6019796.lOV4Wx5bFT@kreacher>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Tue, 2 Jan 2024 14:18:43 +0100
Message-ID: <CAJZ5v0j6vspzj00ZH66eHtcDP8_fUcaR+KNoaTA8qG1r0hkrVQ@mail.gmail.com>
Subject: Re: [PATCH v1 0/3] PM: sleep: Fix possible device suspend-resume deadlocks
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Greg KH <gregkh@linuxfoundation.org>, linux-pm@vger.kernel.org, 
	Youngmin Nam <youngmin.nam@samsung.com>, rafael@kernel.org, linux-kernel@vger.kernel.org, 
	d7271.choe@samsung.com, janghyuck.kim@samsung.com, hyesoo.yu@samsung.com, 
	Alan Stern <stern@rowland.harvard.edu>, Ulf Hansson <ulf.hansson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 27, 2023 at 9:41=E2=80=AFPM Rafael J. Wysocki <rjw@rjwysocki.ne=
t> wrote:
>
> Hi Everyone,
>
> As reported here
>
> https://lore.kernel.org/linux-pm/ZYvjiqX6EsL15moe@perf/
>
> the device suspend-resume code running during system-wide PM transitions
> deadlock on low memory, because it attempts to acquire a mutex that's
> already held by it in those cases.
>
> This series addresses the issue by changing the resume code behavior
> to directly run the device PM functions synchronously if they cannot
> be scheduled for asynchronous executions (patch [3/3]).
>
> For this purpose, the async code is rearranged (patch [1/3]) and a
> new variant of async_schedule_dev() is introduced (patch [2/3]).

Given the lack of negative feedback, I've queued up this series for 6.8-rc1=
.

Please let me know if there are any issues with that.

Thanks!

