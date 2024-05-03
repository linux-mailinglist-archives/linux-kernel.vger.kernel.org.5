Return-Path: <linux-kernel+bounces-167602-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0466A8BABCD
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 13:43:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AAFEA1F22DA7
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 11:43:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 406A1152DE1;
	Fri,  3 May 2024 11:42:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="P+/CkDPl"
Received: from mail-ot1-f48.google.com (mail-ot1-f48.google.com [209.85.210.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 125CC152198
	for <linux-kernel@vger.kernel.org>; Fri,  3 May 2024 11:42:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714736572; cv=none; b=EPgqHOcQ8dTjzokQZXVSBlScFhyfG6sV6h/IrBFGpts9OJ977k1fGdm/bcVsTibCyvi61hSqB9jqNf+xC7z7cA2pFBTLmyt0z3pcKKmnDQaq1aBiOrS7zGtJEuxEkit0X52d0+13HjmlMzdhT4KzWUadVEXhQSQOKmzOV/PK/Fw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714736572; c=relaxed/simple;
	bh=/wlb8TiqJK+x6as5LHo7tXicTp/D7BIbTNgcz0tBL7M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jMZmX6hGprKG4Es29AoyvI9R7c+6O0v4me3BpI4eebIDzI6ipe5XGzBTRxSQdSQvoK/mzftPMR+Jwd+Zv5q+5Sw54J28B8Kk9x85sbRVz30Y8QL6KVIJXifDuBu6hRFgiEt0DS0LLy5H1+r7BEpGb3zMYLXEVuJfeomj5+jOLfI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=P+/CkDPl; arc=none smtp.client-ip=209.85.210.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-ot1-f48.google.com with SMTP id 46e09a7af769-6ee2d64423cso3605276a34.2
        for <linux-kernel@vger.kernel.org>; Fri, 03 May 2024 04:42:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1714736569; x=1715341369; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=cawhOxgt5c+quQfk7K7byhyd32UGGEJDRxeJnf59vWI=;
        b=P+/CkDPljuRPCYpcLvOjfsBVnD5z25T4uZgNHV0zjkGRDYHWi/MJlSWT6I6o4l3nMG
         Y70CRPzwYu1pWhJatpEa3aN0pv8InvL5r2yn7AFldnelt7UYNK3SeR2Y0iZnuDCiaeSJ
         cEWa4oF7ixvZM3jW52oClpJ9TA1owu3yNWAvM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714736569; x=1715341369;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cawhOxgt5c+quQfk7K7byhyd32UGGEJDRxeJnf59vWI=;
        b=ToAD8I5EnC1AdaztWoj3jsKbwko7TLj9Q9+3ygssyd9qh8KnkJkuvIEMAzcfjYGjBn
         jm3ZRQSKSdQzPIZFa5fnTckm6S6lMsIyfUHJgVswlAczQlzlgdNS1n8M7ybvNeCEEAZh
         InJQvYwYJ86wUVriICc0dvDAND97SirhSgSXTnMtz5sGi9BhNOWb71DV0wlbUI3wfz9C
         K6c5d8cyCMCm9VebAz8Y79bgtkplbRUw/gzcgDuFasUYWes+QsEF9L9hKaDvxL47CZac
         zrnhCWVF6i+uwdCSEDa14jdD9PWj40pTFHBDg2jP4zEoKor0zMQorQSMIHGW27xTtzNT
         Vt9g==
X-Forwarded-Encrypted: i=1; AJvYcCUl2e+Jz/8soj3RV1yReEz3yWbCcqynVRyWjqF9cy0Osx5pf0LB51AOysOwXRPnf4B1SUAKWW6qJdTARVHpDjdlqj08LFkhgWEgz1RB
X-Gm-Message-State: AOJu0Yw41woEITGaqwk2FaP73dmFtyN6fBV/bNjp1yAfCGi6oKge0Tf9
	78lY4EU/BSc/luw8QIKGjxdgO4YC23FT2zOTYMHEIAw+m9ElagYhLto6/3L4gmhV0IE31qX0aEI
	DhA==
X-Google-Smtp-Source: AGHT+IGvVILXrEK2XdyaWCK3I93riV2utThB3BS5Sdh9BR4tU6xWiCBX0Go6irkCMoLXXmu4R40+nQ==
X-Received: by 2002:a05:6830:10c3:b0:6ee:3232:46ce with SMTP id z3-20020a05683010c300b006ee323246cemr2623365oto.32.1714736569532;
        Fri, 03 May 2024 04:42:49 -0700 (PDT)
Received: from mail-oi1-f178.google.com (mail-oi1-f178.google.com. [209.85.167.178])
        by smtp.gmail.com with ESMTPSA id j5-20020a056830270500b006ee5c675e42sm581702otu.49.2024.05.03.04.42.48
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 03 May 2024 04:42:49 -0700 (PDT)
Received: by mail-oi1-f178.google.com with SMTP id 5614622812f47-3c70999ff96so4943809b6e.2
        for <linux-kernel@vger.kernel.org>; Fri, 03 May 2024 04:42:48 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXNhk9PcOPlINXyjXCW66NZNENdAtItbbNX+4EnPtrXyObSB8kodLu5mAWzoA45jR4OqXK/lWedqyoNcx7YXBFyJhidJxzok70E6uMT
X-Received: by 2002:a05:6808:9aa:b0:3c7:2030:9820 with SMTP id
 e10-20020a05680809aa00b003c720309820mr2335714oig.33.1714736568411; Fri, 03
 May 2024 04:42:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240503-fixdoc-v1-1-44d26e6f9dba@chromium.org> <60c08e6b-4a1b-408b-9317-3abe1346cdc5@xs4all.nl>
In-Reply-To: <60c08e6b-4a1b-408b-9317-3abe1346cdc5@xs4all.nl>
From: Ricardo Ribalda <ribalda@chromium.org>
Date: Fri, 3 May 2024 13:42:34 +0200
X-Gmail-Original-Message-ID: <CANiDSCsN8yTMBmORrmLvKuMHdJ+Durj8gWV8HK7gGP=x0kqMiw@mail.gmail.com>
Message-ID: <CANiDSCsN8yTMBmORrmLvKuMHdJ+Durj8gWV8HK7gGP=x0kqMiw@mail.gmail.com>
Subject: Re: [PATCH] media: cec.h: Fix kerneldoc
To: Hans Verkuil <hverkuil-cisco@xs4all.nl>
Cc: Mauro Carvalho Chehab <mchehab@kernel.org>, linux-media@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Fri, 3 May 2024 at 13:41, Hans Verkuil <hverkuil-cisco@xs4all.nl> wrote:
>
> On 03/05/2024 13:33, Ricardo Ribalda wrote:
> > is_claiming_log_addrs documentation was missing.
> >
> > fix this kernel-doc warning:
> > include/media/cec.h:296: warning: Function parameter or struct member 'is_claiming_log_addrs' not described in 'cec_adapter'
> >
> > Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
>
> Reviewed-by: Hans Verkuil <hverkuil-cisco@xs4all.nl>
>
> Hmm, that happens when you don't run your own patches through the build tests :-(

There is an easy way to test your patches with gitlab. No need to
install anything in your computer :P

>
> Regards,
>
>         Hans
>
> > ---
> > https://gitlab.freedesktop.org/linux-media/media-staging/-/pipelines/1169148/test_report?job_name=doc
> > ---
> >  include/media/cec.h | 1 +
> >  1 file changed, 1 insertion(+)
> >
> > diff --git a/include/media/cec.h b/include/media/cec.h
> > index d3abe84c9c9e..d131514032f2 100644
> > --- a/include/media/cec.h
> > +++ b/include/media/cec.h
> > @@ -187,6 +187,7 @@ struct cec_adap_ops {
> >   *   in order to transmit or receive CEC messages. This is usually a HW
> >   *   limitation.
> >   * @is_enabled:              the CEC adapter is enabled
> > + * @is_claiming_log_addrs:  true if cec_claim_log_addrs() is running
> >   * @is_configuring:  the CEC adapter is configuring (i.e. claiming LAs)
> >   * @must_reconfigure:        while configuring, the PA changed, so reclaim LAs
> >   * @is_configured:   the CEC adapter is configured (i.e. has claimed LAs)
> >
> > ---
> > base-commit: 1aa1329a67cc214c3b7bd2a14d1301a795760b07
> > change-id: 20240503-fixdoc-d1380eb243cd
> >
> > Best regards,
>


-- 
Ricardo Ribalda

