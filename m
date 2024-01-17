Return-Path: <linux-kernel+bounces-29301-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DBCF4830C61
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 19:03:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DD1071C21254
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 18:03:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EE2322EF5;
	Wed, 17 Jan 2024 18:03:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="S21/C8GO"
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 841B222318
	for <linux-kernel@vger.kernel.org>; Wed, 17 Jan 2024 18:03:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705514594; cv=none; b=UYi5R6qk8aZP3cBLpdUOz/tNdO4YolzDwxhI4emU27ejlhFUrHPvOv2k6CZtiGA2OvbYUYqhy6IekNGCnS/MG8bjjru9ERykugcJMIuCDGYQ7b/4e0WmhARTXlTalybHWQd8u7fVS1aQyu/jgeVReLPwfiLi58rDmOVyfOwycUs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705514594; c=relaxed/simple;
	bh=PF3mblge/X+Hf6n9SxY0sMRIf633kDVBXLyJRgNDNc4=;
	h=Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Google-Smtp-Source:X-Received:MIME-Version:
	 References:In-Reply-To:From:Date:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding; b=nma8ZIxBcL6FuUQ8ofbFkGifNf28V30kKaulHYzLItzbBczGDEkG5Hacm8wM+T8rIN2sGf4ga9bcL/xNe5pRI13qziMxx7Ack5g++1t0mTXQsk08qkL6J5FeaiWNvJYVQLkHm/jyCH+cPb/TaJ3/4+3N8gYUBe71SatMbmuBioI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=S21/C8GO; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-1d6f1df9355so121105ad.1
        for <linux-kernel@vger.kernel.org>; Wed, 17 Jan 2024 10:03:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1705514592; x=1706119392; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jKIkJ8HVuiESr/1rRSa9mU8k54RTWjGhYSPWVBq0UKI=;
        b=S21/C8GOnkri4U+++W9FcquwT0bNUwqiLKssodG1ezkhXk5nMeI0tKnQ9kb/STR4ZR
         QbuWIJjkC5EfZ+O7LzlSKeRvhcMM/bx6mijUmLpYivkYXel8MZD90cO1H5rxOn2o9XJa
         6/MtOE5U3GHQX0U4ebQI8y/005jzq4SUNMG37eU+SF4PpaavdUSOerjhxV026wE5tm2w
         khxfB3w2ymZ7q3OYa7tv5WkgNGxCBSurVSdLv2uPqDVp5WZeANKbDT+ngfc5iLoJN+BV
         EIRKSaxsWmSD7x/wHB6hrJ5KdXUZbUH34LrvepDwpvfrVA3luz6FwfgP5M6qI1LknJT9
         WfTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705514592; x=1706119392;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jKIkJ8HVuiESr/1rRSa9mU8k54RTWjGhYSPWVBq0UKI=;
        b=FiHy2OqQkCvtfCwH5WYGT8rwj15GnyMvTMugpS9vX/owYxW9LJsNBl5IZioYCsy9C6
         CrbxFxHegpX3d/ABVYOmzyvK9Q9V0sdvMhxmhdLGXwaG5P7JCTFMz4Vq/Hw21McV9NGm
         XT6Alx70QSGqiMo0IaP8jyhvPZdpu82kjIcOF+H7SG3CpsAirPxE/MhEN8Qd4CCeK5C9
         2j/J0hDBSv5iK/MMJDu71UjZVKShH+fX824DFN4IabX0X8S8fm7/hKs0Z9BRaokA4w8q
         f+kMt62I1qG8y6/5zBnvJsqv5CsJ0WGpS9waEe9agL41bMPnFXOgipdy4tMVn84HerPx
         zSQw==
X-Gm-Message-State: AOJu0Yz2vpl3MBjvC5LQjTc8iCBXuoVxQe51kJEF+CVx9H4FnMZGDhdW
	9e1jAHcaGQIaF8kGWfiQIn91BeFzlCoJmBlAWtFcjJS0irRiksy+8XArv9QpyrYTAyG6MUksGI5
	41FfoU5o+RLdv0iT+Y66oOeEBzAos2f7lU/Ay
X-Google-Smtp-Source: AGHT+IFh86v+PhJTZZIVLlayRBA7EsrDxOfH6lDP3Q4ks+aqgEeV9VUNdJ3AERsfGCIrt+xg+8GcNZjP7UcIEWEO4bI=
X-Received: by 2002:a17:903:24c:b0:1cc:6fa6:fb4a with SMTP id
 j12-20020a170903024c00b001cc6fa6fb4amr224768plh.22.1705514591692; Wed, 17 Jan
 2024 10:03:11 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240117141405.3063506-1-amitsinght@marvell.com> <20240117141405.3063506-14-amitsinght@marvell.com>
In-Reply-To: <20240117141405.3063506-14-amitsinght@marvell.com>
From: Peter Newman <peternewman@google.com>
Date: Wed, 17 Jan 2024 10:03:00 -0800
Message-ID: <CALPaoCjf_A5SOr8L+0WMePW02Pzj9nnPT0JLZ_+232vvfEzGCQ@mail.gmail.com>
Subject: Re: [PATCH v1 13/14] arm_mpam: Handle resource instances mapped to
 different controls
To: Amit Singh Tomar <amitsinght@marvell.com>
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	fenghua.yu@intel.com, reinette.chatre@intel.com, james.morse@arm.com, 
	gcherian@marvell.com, robh@kernel.org, dfustini@baylibre.com, 
	jonathan.cameron@huawei.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Amit,

On Wed, Jan 17, 2024 at 6:15=E2=80=AFAM Amit Singh Tomar <amitsinght@marvel=
l.com> wrote:

>
> +/* Club different resource properties under a class that resctrl uses,
> + * for instance, L3 cache that supports both CPOR, and DSPRI need to hav=
e
> + * knowledge of both cpbm_wd and dspri_wd. This is needed when two contr=
ols
> + * are enumerated under differnt RIS Index.
> + */
> +static void mpam_enable_club_class_features(struct mpam_class *class,
> +                                           struct mpam_msc_ris *ris)

It looks like "club" is used as a synonym to "class" here to evade the
bigger issue that mpam_classes are not defined correctly as DSPRI
resources should not be in the same mpam_class as the L3 CPOR and CSU
features.

This hardware makes it clear that the definition of mpam_class as all
resources in a (level x {memory,cache}) needs to be revised.

-Peter

