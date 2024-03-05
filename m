Return-Path: <linux-kernel+bounces-92064-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C929871A57
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 11:14:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 053171F222A6
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 10:14:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 831CC548E0;
	Tue,  5 Mar 2024 10:14:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=9elements.com header.i=@9elements.com header.b="fTAIHpkT"
Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E1EC535DC
	for <linux-kernel@vger.kernel.org>; Tue,  5 Mar 2024 10:14:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709633689; cv=none; b=G/mCvulxVnOFhR2KTMMMSDnGcPWfgpdKAlyc5L0eLZ847CpodccOIDGO9hiEx0AGM+Jhjk8vhvOuiMLuzUUuHRCFjnr3pr+AZqE3oFmFCCt5uvUctll79NTXu+0U7XM2VpLwMNUixEQnJX4zOs3fsDp0khbnfrNRFWpF7IR2jPQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709633689; c=relaxed/simple;
	bh=XZSjqZ3JSf47Da2QFL1XzdQoirjzawDffre2zOpsvBg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=guGucUBxVDmnsKUi+7ebYzCXVYwW1HsUbQe3cxheQIm3ZYxRXTa9SjNW1liSD6OCLic2ujr20It5tjUBio0x4FGWfpASlrYo3xsQOHkgmqo4g9K0RMn8hlUDtoYIdHXta8w2vnIEdp+SagJcynqN3kRNOlpnuApG13U0goM40wA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=9elements.com; spf=pass smtp.mailfrom=9elements.com; dkim=pass (2048-bit key) header.d=9elements.com header.i=@9elements.com header.b=fTAIHpkT; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=9elements.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=9elements.com
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-5ce942efda5so4478178a12.2
        for <linux-kernel@vger.kernel.org>; Tue, 05 Mar 2024 02:14:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=9elements.com; s=google; t=1709633687; x=1710238487; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=XZSjqZ3JSf47Da2QFL1XzdQoirjzawDffre2zOpsvBg=;
        b=fTAIHpkTMNkKAVH5L4rPqTS426w5kZwPDjPltYNItv24Spop5YYM76Lpt8gzah3PzG
         AyhT2eVp+xi5ZyEtBgl5IvLY8Dvc3dM8fzshD513YoDRWUpG2OR9twhqXdPCFcgG7o7E
         Lfu174/V1Uv7fcB8zKBJ1jDiQDCpm/495yh7n9CV/1GllBb+MnMCsR2qYsz4ByV8ctPy
         wrfi+rX5QAotfzGdJJxJzcau02SLbn4cksiYDUFcAbNZpFaj5Xfoup0YfchVCne+Cmbx
         CbwR7z6flu5vboaTd3Xlpe+0FJ/JxKXohLEM9h6ChcqL9QyV4ChostU48mFoqOIszUl+
         3iZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709633687; x=1710238487;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XZSjqZ3JSf47Da2QFL1XzdQoirjzawDffre2zOpsvBg=;
        b=mLK2dp0UxQj+iUhosReZmVxldo/whPnxE9qiQzU8pNhGBBLcmnsk3F0lRIG+WiC/K5
         o9KIaQQuzXR743zKYBZA26rUjoiGoWYmvGdmcP1VlKS4FoIW/isPvSx+ByPTVXIkVYSU
         UdUwZAjG3dR3tfmf8TSDP84UlvQUJhp2sd8bUnJhDje71QzGh2x8hhErpQE1/1gBJ770
         6FWRPytKVA+EGvt6FR2J15YKOtJgU2Cttmx7kQCijEL29fR/iYJjnE+MzQyt96SllnYR
         dJVByLnrOR7hTIYC5hlXFDSnpqme9w20Xz6MqrzNwvv2ECTmeyDRmsEqfm/xPeHkhf3l
         kTqA==
X-Forwarded-Encrypted: i=1; AJvYcCUTVjDIKPo1YNHbwa/+5dyfZI6qA2d2Oh6RHM46T0XTprAsZLv2DRFAQ9wR3ttPIxlScIMrsaIaMiAK/CO/XYbzOLwKZs7Lj9hblhyp
X-Gm-Message-State: AOJu0YwdTEx2uQyS6zR5N8ePt1SaZ1T7qlBg2NkmtHcmZXuyNGtf8QlI
	z/wPtt+oe2B0gPIMnynX1Sh6IjeF/8XycPd3m8atnrme36jYcT/Dt9OmjKejETwTai0ZWIoDKr9
	VoUqLvshN0aVNAXnvMp/vci1kWEDhGcG2hWG1Og==
X-Google-Smtp-Source: AGHT+IHS33vobaUrrJ8bJjIllSw7958PJUMYVf4Uq2M4zLgrKScGVOnJ8NONP1gs3gkiBAzcHEueHL7hQJMA+7Bth4s=
X-Received: by 2002:a17:90a:7143:b0:29a:842b:d8b3 with SMTP id
 g3-20020a17090a714300b0029a842bd8b3mr8853381pjs.7.1709633687461; Tue, 05 Mar
 2024 02:14:47 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240304164446.4153915-1-naresh.solanki@9elements.com> <3383421b-bda2-48c5-bc49-d3d9f2ecfe25@roeck-us.net>
In-Reply-To: <3383421b-bda2-48c5-bc49-d3d9f2ecfe25@roeck-us.net>
From: Naresh Solanki <naresh.solanki@9elements.com>
Date: Tue, 5 Mar 2024 15:44:36 +0530
Message-ID: <CABqG17jJibwOcRbgutVh1-QDVpcYPBbUSm2pC=jw7EiRAMyt4g@mail.gmail.com>
Subject: Re: [PATCH v2] hwmon: (pmbus/mp2975) Fix IRQ masking
To: Guenter Roeck <linux@roeck-us.net>
Cc: Jean Delvare <jdelvare@suse.com>, mazziesaccount@gmail.com, 
	Patrick Rudolph <patrick.rudolph@9elements.com>, linux-hwmon@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Guenter

On Mon, 4 Mar 2024 at 22:30, Guenter Roeck <linux@roeck-us.net> wrote:
>
> On 3/4/24 08:44, Naresh Solanki wrote:
> > From: Patrick Rudolph <patrick.rudolph@9elements.com>
> >
> > The MP2971/MP2973 use a custom 16bit register format for
> > SMBALERT_MASK which doesn't follow the PMBUS specification.
> >
> > Map the PMBUS defined bits used by the common code onto the custom
> > format used by MPS and since the SMBALERT_MASK is currently never read
> > by common code only implement the mapping for write transactions.
> >
> > Signed-off-by: Patrick Rudolph <patrick.rudolph@9elements.com>
> > Signed-off-by: Naresh Solanki <naresh.solanki@9elements.com>
> > ---
>
> What will it take for people to start providing change logs ?
> Why is that do difficult, and why do people seem to assume that
> I have the time to look up old e-mail chains ?
>
> I'll have to write some boilerplate reply. Until I get to do that,
> I'll simply ignore patches without change logs (which I will do
> once I have the boilerplate as well, only then it will look nicer).
Yes I understand change log is very important. I missed adding that.
Will resend the patch with change logs.

Regards,
Naresh.
>
> Guenter
>

