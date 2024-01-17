Return-Path: <linux-kernel+bounces-29360-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 75C0C830D3E
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 20:21:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ABEDE28CD1D
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 19:21:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43478249EB;
	Wed, 17 Jan 2024 19:21:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ukbxDC9A"
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C9E7241E0
	for <linux-kernel@vger.kernel.org>; Wed, 17 Jan 2024 19:21:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705519295; cv=none; b=QF9cCH/E1S+PamhUbIAin2ifpaqNcbnpsCGgFqeQNXkCtW+kLtvAKCgMGO9e/ZXxv20Z2BogxzwiKs4bP4Se/RO8Oroa69Zd3ll6sYsm/3aftg4fqxiURyjW59o23m3HOPHLCx8lnlHnwOuKQOueIpYCUBmzdYQ1vWhkta49D1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705519295; c=relaxed/simple;
	bh=+6PjGw5k2/rxum53I0W97io8g9vZHuH6ioB1XOMaR0A=;
	h=Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Google-Smtp-Source:X-Received:MIME-Version:
	 References:In-Reply-To:From:Date:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding; b=vF6Qtjpd8Z6OAHTyofyuHvG5Zyu3y8UmmQ8tN34JWfe9l1Z73mYKo1RBhriWXeGdBYNEx6WK0+NDL2AjyMpI5+4ZI8VV890nz4JugQw6N93BTKwnHeKjwtCW5551t8wettTgbaH6qyfcyRC2NStScjkMC4QM83icmz8tcxw6rik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ukbxDC9A; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-1d5ebcbe873so167355ad.1
        for <linux-kernel@vger.kernel.org>; Wed, 17 Jan 2024 11:21:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1705519293; x=1706124093; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aQp9V8Yb7WV1gbNl0kx0pG4yvjrKbCk2B0ZNg/khk8s=;
        b=ukbxDC9ApwhbUy9e1WKBgNeh8WS5vYOQKsyKbcHVMTAWj27mi+InMc0qbRbY0L2IJ9
         wE2FqqEMkTh8l76d2si64OYb+gfZ7bduSx/py8LUTq8k9gAhsScWBCOQnCzimlnQFypV
         7h1YiOeFoqNk+ONt9Exe4fw681N6BojLN3sBmXTwHVr0RK/LjwXTe3nC12wmeNw9at5v
         ClSPhxPONyiy2h3LVH79aMT/i6qq4x4Y1C3KCrb2yAnps2Ym8UkNlcNIKjVos8Z55R2N
         /TzEbc92PwgCQS98yPX4UPKeGt+np//il2QpjkEGQbOneJb4ITnqY/3HceNCDejGZeo8
         VtaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705519293; x=1706124093;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aQp9V8Yb7WV1gbNl0kx0pG4yvjrKbCk2B0ZNg/khk8s=;
        b=jVYHTOmAiicyGbWpDCk5fzxJ2gMxHyYdsjYLcLnijBr7aR2LaAyzyzQXA+ytBBKOxv
         w3jthEdWehwdtvdyPdn7QHWjtdif4C49iFDjCUUn8kVRBvjduKriIEWxTT8ts4pKVW8H
         zYipjiZy7Nu6/Vh2CandEtsRRTQcnTF2mAXScLGBcOerOvXPXht9Ixurx2OisG0CmFnQ
         egivImJ4m8sCCo7y2qWfgu8t+NVEA21GxQyBHqLGEEh/8s812b/MErEwbl+Vq6ubte+Y
         ZlvjTBnARzvQRILysjA3yyIBt1qkzGcd7zTRfWog4WRmDKr2YMIzg4nOG5muN1BkS71F
         4DgA==
X-Gm-Message-State: AOJu0Yzl36d6buvFVozwHsggl3a9ciht7PAn+tGwEyC0LZsrNcTk8dXJ
	m9jjJ/sDJ2sx0t2i4D1XGIwyyC3iRABIN7TIfB4ns2Sm4UqAsgc6XosLegZECQwESi46SVpeAaM
	AU9ueR6G21ZTxc3Vr4YXfuyWvy4TF2kNRYmwnut152uls7cd50w==
X-Google-Smtp-Source: AGHT+IEFvRGL3Zx/Jzy8jifJ9reRMWCNHJIbrzKWY0KTUzYkSPzPSvbEozYzMARvxThxHC+OY6B7ARG0C18FssSPDYk=
X-Received: by 2002:a17:902:e803:b0:1d5:a556:7662 with SMTP id
 u3-20020a170902e80300b001d5a5567662mr212787plg.9.1705519293321; Wed, 17 Jan
 2024 11:21:33 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240117141405.3063506-1-amitsinght@marvell.com> <20240117141405.3063506-2-amitsinght@marvell.com>
In-Reply-To: <20240117141405.3063506-2-amitsinght@marvell.com>
From: Peter Newman <peternewman@google.com>
Date: Wed, 17 Jan 2024 11:21:22 -0800
Message-ID: <CALPaoChguTrJPtgtxXkNd2sJdFLajWq-CcKeCd__pfuUye+43w@mail.gmail.com>
Subject: Re: [PATCH v1 01/14] fs/resctrl: group the resource control types for
 schemata list
To: Amit Singh Tomar <amitsinght@marvell.com>
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	fenghua.yu@intel.com, reinette.chatre@intel.com, james.morse@arm.com, 
	gcherian@marvell.com, robh@kernel.org, dfustini@baylibre.com, 
	jonathan.cameron@huawei.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Amit,

On Wed, Jan 17, 2024 at 6:14=E2=80=AFAM Amit Singh Tomar <amitsinght@marvel=
l.com> wrote:
> diff --git a/include/linux/resctrl.h b/include/linux/resctrl.h
> index 3ad308e9e226..125c4b0c2ff7 100644
> --- a/include/linux/resctrl.h
> +++ b/include/linux/resctrl.h
> @@ -249,6 +249,7 @@ struct resctrl_schema {
>         struct list_head                list;
>         char                            name[8];
>         enum resctrl_conf_type          conf_type;
> +       enum resctrl_ctrl_type          ctrl_type;

I don't see a difference between a conf_type and a ctrl_type other
than conf_type being used for CDP and ctrl_type being used for DSPRI.

>         struct rdt_resource             *res;
>         u32                             num_closid;
>  };
> diff --git a/include/linux/resctrl_types.h b/include/linux/resctrl_types.=
h
> index 3897de9c4ecb..b9268ec3ba71 100644
> --- a/include/linux/resctrl_types.h
> +++ b/include/linux/resctrl_types.h
> @@ -57,6 +57,12 @@ enum resctrl_res_level {
>         RDT_NUM_RESOURCES,
>  };
>
> +enum resctrl_ctrl_type {
> +       SCHEMA_BASIC =3D 0,
> +       SCHEMA_DSPRI,
> +       SCHEMA_NUM_CTRL_TYPE
> +};

Rather than enumerate every control type on all implementations, I
would prefer the approach taken in the MPAM resctrl_arch_rmid_read(),
where the MPAM driver would embed the resctrl_schema into a private
structure it defines and use container_of() in
resctrl_arch_update_domains(), which should take a resctrl_schema
parameter instead of an rdt_resource. Like resctrl_arch_rmid_read(),
the containing structure would direct the values to the appropriate
hardware.

I would like to see the MPAM driver owning the enumeration of this
feature and the common FS code just understanding the control as a
value that is passed back to the driver if its value is within a
stated acceptable range.

I think there's still a lot of work that needs to be done in the
overall design of resctrl to provide general support for controls and
monitors which do not exist in RDT and these patches provide useful
information to help us understand the issues.

Thanks!
-Peter

