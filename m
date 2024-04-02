Return-Path: <linux-kernel+bounces-128841-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BC20089605E
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 01:46:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EE0201C2284C
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 23:46:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C1FE86243;
	Tue,  2 Apr 2024 23:46:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="avX4J5MT"
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C14292260B
	for <linux-kernel@vger.kernel.org>; Tue,  2 Apr 2024 23:46:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712101582; cv=none; b=MPs8Oc/TZ/bkkoUMTruyNmJ0F8z1z26B+Nso7ajMDW+LQe82vWTucmgTsH81KVHeA5t2oD0z3kqkLQtwvJ8RFDS7UkHoe80TK10iDMibLDRA815UsHS/boNqyzIQdhueunUaD8YtaBo5NKyXAt0Ge9afGGoXi4BG+rRZKgJju3E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712101582; c=relaxed/simple;
	bh=8rjYFhZ2XZOMdRtdKWh5HY7bv+xevdxUD/lIqWYydlc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=foOCczAMF0qLz+M1TiMk34b8B9AcbIqriZwNOe6Ht9e1H6VQ5yTQrvx9AVeZgcUywMxP/4rT7sL2SjevFJZBwA8lKnuScE4eQBOoq5YpdYOzS8UAL6DMz6Kr9kxCR/NQGSOV/PZndQIizESCw4IeSnfWlW2CetjarI/dzdzigog=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=avX4J5MT; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-41549a13fabso17505e9.1
        for <linux-kernel@vger.kernel.org>; Tue, 02 Apr 2024 16:46:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1712101579; x=1712706379; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YUNb1EO5EhlkTVd2eVYclB+K26JgugQcOcoodC1uf8I=;
        b=avX4J5MT5tpRpo+mrOOp5qYjieJknCfCkWEpOXPVzT7uS5tSueI/7kIvZmdSLxBfYS
         Gi6tg+dO3RRNiOVNpy20RDGc4BsrfOBmyfGS83/q6HwZ3LNzQqYF67v48+qZEzjKZuP6
         rpsMDD1e765ATdJpnC+Jgk4dpfMW1T0Tv3isrpamg2GdkT9im6mr+5ay1ygyAFIz7//G
         EERbK4P2SlzymvLhJEKj1K+swWUsxjS3xsbs9sFIavKvwYkiJYwienhSSKM0dE18gMO9
         oQB5RUgg2fv72nXr0qdgvZrvBQ7riADWpMGCyBE1oDeJHlQFJn7HAElkT3NisVQkmlnK
         FyPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712101579; x=1712706379;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YUNb1EO5EhlkTVd2eVYclB+K26JgugQcOcoodC1uf8I=;
        b=L+X8o3u45/Mj5Y2YaWU+zaPWLvtV3LDyQP3jjLy56gWauLxfKQYb7nHYW3Vh4lXcC7
         8z38YNb3h9gkqqS7TyR1b56/bfGNqFn7uROiEQXao8QbGTWPKekq7IZPIrhytlXylpW5
         4SSeJ1nP+kv2HdEpRYeD4VcH+Kw/kvrpHGsbu7ObQ9eiicWXNDHpTQwObt55WzL9MxAl
         I6R9LK/3YH/ZQKB+mzHrOhQ2lGZaRLbNlv8VyLMgGvZ21Ed90t/XNOtyRgddk662SeGh
         ZUcWQ9yPR3uFcIdDyYE4xtNcXMaYXWy9p5VPn3vATM82rwnuxZthI1u6My22wOrfjQpp
         QmKw==
X-Forwarded-Encrypted: i=1; AJvYcCUvEAxxW7TNNWfyAcICqOhhz3z1ozd4lyOHcLJUiT8lsBIohWGKC/dNw1pBAeeOA+vP5hOnHbsUzxx/pUZeBhJHSGmQS9eDDwlLj8tE
X-Gm-Message-State: AOJu0Ywpjn+rTziBPIFXLdPHIg3zhbd5pY8xKqlaFft/thw/UaBVRMVB
	aO1Tdo4e5/kzKYYo1DAtA6Beh+hXY4kL+xAaL22CQDP12Rl+hk7oHJEORVkKbsCNnhwtquk04CS
	PtTn7xbDbF2GOSNwys317Lsu5lwGI/asQFxU=
X-Google-Smtp-Source: AGHT+IEmYVbIjpVLK/TMJN0yY1My4fZGvskmgZhqDxCmuone6eq2XC2v7DwNW4m9fNY6Q0NitdNoOS1JB5uIbrqrtbU=
X-Received: by 2002:a05:600c:1c12:b0:415:615c:b98b with SMTP id
 j18-20020a05600c1c1200b00415615cb98bmr38387wms.5.1712101579027; Tue, 02 Apr
 2024 16:46:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CGME20230901010734epcas2p4aadced02d68d3db407fda23de34601d2@epcas2p4.samsung.com>
 <20230901010704.18493-1-bongkyu7.kim@samsung.com>
In-Reply-To: <20230901010704.18493-1-bongkyu7.kim@samsung.com>
From: John Stultz <jstultz@google.com>
Date: Tue, 2 Apr 2024 16:46:06 -0700
Message-ID: <CANDhNCoFRr=qizswLm-dzxJK0fHuCx98Z2B1pUspdwGqBEejYg@mail.gmail.com>
Subject: Re: [PATCH v2 0/2] Make reader optimistic spinning optional
To: Bongkyu Kim <bongkyu7.kim@samsung.com>
Cc: peterz@infradead.org, mingo@redhat.com, will@kernel.org, 
	longman@redhat.com, boqun.feng@gmail.com, linux-kernel@vger.kernel.org, 
	gregkh@linuxfoundation.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 31, 2023 at 6:07=E2=80=AFPM Bongkyu Kim <bongkyu7.kim@samsung.c=
om> wrote:
>
> This is rework of the following discussed patch.
> https://lore.kernel.org/all/20230613043308.GA1027@KORCO045595.samsungds.n=
et/
>
> Changes from the previous patch
> - Split to revert and modify patches
> - Change according to Waiman Long's review
>     More wording to documentation part
>     Change module_param to early_param
>     Code change by Waiman Long's suggestion
>
> In mobile environment, reader optimistic spinning is still useful
> because there're not many readers. In my test result at android device,
> it improves application startup time about 3.8%
> App startup time is most important factor for android user expriences.
> So, re-enable reader optimistic spinning by this commit. And,
> make it optional feature by cmdline.
>
> Test result:
> This is 15 application startup performance in our exynos soc.
> - Cortex A78*2 + Cortex A55*6
> - unit: ms (lower is better)
>
> Application             base  opt_rspin  Diff  Diff(%)
> --------------------  ------  ---------  ----  -------
> * Total(geomean)         343        330   -13    +3.8%
> --------------------  ------  ---------  ----  -------
> helloworld               110        108    -2    +1.8%
> Amazon_Seller            397        388    -9    +2.3%
> Whatsapp                 311        304    -7    +2.3%
> Simple_PDF_Reader        500        463   -37    +7.4%
> FaceApp                  330        317   -13    +3.9%
> Timestamp_Camera_Free    451        443    -8    +1.8%
> Kindle                   629        597   -32    +5.1%
> Coinbase                 243        233   -10    +4.1%
> Firefox                  425        399   -26    +6.1%
> Candy_Crush_Soda         552        538   -14    +2.5%
> Hill_Climb_Racing        245        230   -15    +6.1%
> Call_Recorder            437        426   -11    +2.5%
> Color_Fill_3D            190        180   -10    +5.3%
> eToro                    512        505    -7    +1.4%
> GroupMe                  281        266   -15    +5.3%
>

Hey Bongkyu,
  I wanted to reach out to see what the current status of this patch
set? I'm seeing other parties trying to work around the loss of the
optimistic spinning functionality since commit 617f3ef95177
("locking/rwsem: Remove reader optimistic spinning") as well, with
their own custom variants (providing some substantial gains), and
would really like to have a common solution.

thanks
-john

