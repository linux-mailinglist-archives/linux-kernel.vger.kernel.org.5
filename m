Return-Path: <linux-kernel+bounces-100341-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 988AC8795F0
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 15:20:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3A1671F23BAB
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 14:20:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AECD67AE5B;
	Tue, 12 Mar 2024 14:20:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HpVIzNPF"
Received: from mail-oa1-f48.google.com (mail-oa1-f48.google.com [209.85.160.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9830058AD4
	for <linux-kernel@vger.kernel.org>; Tue, 12 Mar 2024 14:20:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710253208; cv=none; b=XBx0mjsZuLoYu5q9VRb8WN/H7FNWXP2Clm6LcRvUlerkrlbR5o5f6k+JMnWmxH4HSYqSRscot7JU/H5Ov1jb3JScSCCgN/bNxWw6UcFRjoc42WOz7pZ2knrMHKX1etQGoE/yEZbl72vFttfw5fzUtLRrvhj2Ts0xCbe7Qg/uqgc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710253208; c=relaxed/simple;
	bh=yLWkWNcxZrMOhG71dZBgbvL7aoLlVdcf7JRuDyoJaV0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dS6Ls+6NjElE2vfcDII9UUSoi0xHm4m8teb8OC66eRYQsOPI5G2TfhBe1Z2bFkyaj6QglfPozzWhv2DPKrJkvhpETpkSatJ+9FJtYRVOzO2b2DSKD3ZybVRtcKFxnbWMmzBOaIANNUGXN6LrwxayysAMVKhhZz3xB5W1QTS6TO8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HpVIzNPF; arc=none smtp.client-ip=209.85.160.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f48.google.com with SMTP id 586e51a60fabf-2220a389390so11473fac.0
        for <linux-kernel@vger.kernel.org>; Tue, 12 Mar 2024 07:20:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710253206; x=1710858006; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yLWkWNcxZrMOhG71dZBgbvL7aoLlVdcf7JRuDyoJaV0=;
        b=HpVIzNPFe8nNEEqkQkSZbbrNaGTPaoE6igGbroKwwrL/fAIq0d5Avk0rLrhJJZeZsn
         eqdmVuPxusLudnYw8kmuPn+DMU7TLp5+cvxkfE2oAx+8BraJU1AMv2wrYrgkm/HgFJoO
         FNFiSJzkot3ttT0OHDwewdgdoeEwFvJbhKJ5EHu8H5OIHoX3uqcKhFIOfoCFDEAoWIkt
         eQswg3Bj9gU1HcXhzQ8XQjhAbmL/JiJZzTZAv0UV3FD3Orhmw/6G0nOM5SwDpqdD/Yb7
         zdkuf+GAzkqfihD56p0iZI/aI6r86LNOlBrIw18lX5KixM7D5vySlpknqH4jfUrmt6iC
         AiDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710253206; x=1710858006;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yLWkWNcxZrMOhG71dZBgbvL7aoLlVdcf7JRuDyoJaV0=;
        b=E1iUxjjHtnvD/3qRzzLA6GzbE/2OXRNI8CUUKmJeZ34WBKW1nltF2M0dIMyjE1btkr
         p/H/sbXQV59JTMRsZrK3meEJer0BA9yCG3v1fHXF5JET/V9bwTn90EleRMsWLCitZtDw
         hgNXoNX+5JDKtBda6+TmYm+d4Jzx+HVBjUIBDAfoR/cOMfyzKukeRNC1knFEmRJAkdam
         U131mgKkd+7KNT34JVWN7h3+nsUJU3NGBjh7XeKRq1Dlel2ewAiumsh6HK0/xr29oDd5
         w1QODAllu8T+1piXzv9Msxi6UDfJDLih1n7TWMGqvIv3hv2xOwG6EgnCcdd56xBMC/UX
         Wq0A==
X-Forwarded-Encrypted: i=1; AJvYcCXN2Flj2DRnyuT/lYgXmT1YMm7aOdYdypqseeeKUFBWPNWHugcQ1R38XV1e4a/Q1vC1GIMAc7zByYogjtjPA7t3Kyd+RvCOrthnyWtV
X-Gm-Message-State: AOJu0YyYQmLq5rP1sRIHkEjde2Gt8I7PPlG2YeJYPu/Ur7nkZKj9ujfa
	PmyxMWqHTIiKT4rmDdH7a39NcoNXch8MuaDxmEWYnVuVGbpt0NXZ4nMhTOhUBX0jl7x5sr6s7lM
	Ii3Qgp8dyDzu5m4VPj6F/ly1+xkA=
X-Google-Smtp-Source: AGHT+IFUvA38hFpGRTEzMMcAC6G2tUkiK1zHM9xDi/u2h1IFr1nD2XuRavJOZMBSAUcKJZVn1eE6s7Aa5WzfRPjpDes=
X-Received: by 2002:a05:6870:b68f:b0:221:8858:b3af with SMTP id
 cy15-20020a056870b68f00b002218858b3afmr3909933oab.15.1710253205718; Tue, 12
 Mar 2024 07:20:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <Ze9Ie67PCSvBU+og@MOLeToid> <6d643351-8924-4c86-9fb5-9951e016f5db@gmail.com>
 <b9cc75d2-3e06-43d6-8b70-38d1c97124d2@gmail.com> <Ze+LMgwYYK6LN79O@aschofie-mobl2>
In-Reply-To: <Ze+LMgwYYK6LN79O@aschofie-mobl2>
From: Felix Kimbu <felixkimbu1@gmail.com>
Date: Tue, 12 Mar 2024 15:19:54 +0100
Message-ID: <CAK=vLxLensipg0BMCW-r83+-tQn03XQ5naKOsPOrJa6gf8i7SQ@mail.gmail.com>
Subject: Re: [PATCH v2] staging: wlan-ng: p80211conv: fix indentation
 problems, introduced by previous commit
To: Alison Schofield <alison.schofield@intel.com>
Cc: Philipp Hortmann <philipp.g.hortmann@gmail.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-staging@lists.linux.dev, 
	linux-kernel@vger.kernel.org, outreachy@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 11, 2024 at 11:52=E2=80=AFPM Alison Schofield
<alison.schofield@intel.com> wrote:
> Please follow process for revisioning patches here:
> First Patch Tutorial Section: Revising your patches
> when you send a v3.

I appreciate the feedback.
Thank you and best regards

