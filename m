Return-Path: <linux-kernel+bounces-46144-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 749D3843B34
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 10:34:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 297F51F29D8A
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 09:34:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FAA967A16;
	Wed, 31 Jan 2024 09:34:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="USd8qlZY"
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 523C6633E9;
	Wed, 31 Jan 2024 09:34:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706693690; cv=none; b=ROvu8/K5w4ucGJfFkBax3rsKiatC54dsqRqZdFBlK3/Ofvf4Vx2VgVU5587M/eCuyh1+SO2wDudpUYZ0hBkM2ARC/qH08e9MPzGPBJbPPJkuX7nJGWudoltx2OfDacp2iEEtwF23rtT1NwR0jRlSN1MCxAt7azKHncWOYZFRn4U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706693690; c=relaxed/simple;
	bh=0bvmHWRVIhb0Il2NpTti4MBidwTy+fe33l+Bnmw+NIE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RjCzvGyF3MpgIHo9XzEOAUOUr/oJyjGtRqDcl861kC2dHXjswDOS4YWIBOOmJ6rUT9gHV0cPnwYWAoaMtGK9UWK8Ulut18aDGs6x8c1JKpyB/VeYxsKBZz+qZU0sgjx249nxUk2NMV3Dd4N2gZz5npkXBtRRDwjaUbVNfR//zEU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=USd8qlZY; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-55f082c2c92so4342811a12.0;
        Wed, 31 Jan 2024 01:34:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706693686; x=1707298486; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0bvmHWRVIhb0Il2NpTti4MBidwTy+fe33l+Bnmw+NIE=;
        b=USd8qlZYsBLf/2TUvLlAr4KNwopm13pMVMTHPwZs1f01MgPcHMw9FcjNXK30gkt6YX
         QGdJvSP2h8PM+VLfZnta1a6WQqKYkhWvMdGlMmQiTX/RViuqa3yj0L5ZXOkISQ92OXBb
         mxRFmcHXCh5f/MdgJdsl+Io4F2BFc5zHtG6kEVwM5b4i6uvVPVKwu0VdFYtB6SCtk1Dr
         xNTpHsLxRt+qgqmchuIF3grX1e4gJ5vmv/0HfOX2Y3eUDVzPTkKKAdUgpLT7hKLTwoP0
         itC8L9KHUPdVtXh1tJTDJQK8kCM0urCBUaPfbg12pX3WiTmtLskk6fyMYkoZaExRH95W
         7omg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706693686; x=1707298486;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0bvmHWRVIhb0Il2NpTti4MBidwTy+fe33l+Bnmw+NIE=;
        b=P4JxPJEe2S0gnHqzPG7NcV1CJrRiEHmpeSRW4MzvhoU0u34r9CwDvY/2N9wsfKqkS2
         5zILjKbGbxkmNQiy2iDXjc8C6iMMF96T/X6OcZ3wTeWxpVh3/UqPyNnDc7vzOzu8GYya
         VebRvrEXKdA+YjLRBa6yNB8H9Qi0iwqMUJ7CtWda2awsu0Xnvh4aaFvewWKjP61Dbj8F
         iXUy6yF7K0gzgA8b6vmWQNMxgBzYknk4vj6T3ml+JZXpq1Ub3o+bkk/1kiLR+TaCMGkQ
         NT7mdpFvwL1qGUPG/Wcc3vp2F5EP/UrubYcNrQqQhJeJvScgGvjmxmrTV5JHv84wzE8W
         IyRA==
X-Gm-Message-State: AOJu0YxKSrTvayt2PAROIQfvkVRQANqO+yP6hRzEkCukhIkoHbE8w6DW
	1+KD4tA0ik1xzESGZ/kFuIJWZJDvcIKP1YBFoRGpS7mFkZwnGY+kK2xzz7A+TrZZ8LItfg4lLZ+
	zk3Yhfqag6D4lI9gRp/iPwZtufiO7VXSXcOhLhDQb
X-Google-Smtp-Source: AGHT+IGFyt7lQ201fi4xu6j6gSabpBoKZGN4x12n0ouWCLG/sm6Ywl9bRWpFNo8iF8qxkJ2R2K81OAjaBguQzikvjYg=
X-Received: by 2002:a17:906:4f0a:b0:a35:64ff:4817 with SMTP id
 t10-20020a1709064f0a00b00a3564ff4817mr734980eju.0.1706693686267; Wed, 31 Jan
 2024 01:34:46 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240130-rk-dts-additions-v2-0-c6222c4c78df@gmail.com>
 <20240130-rk-dts-additions-v2-3-c6222c4c78df@gmail.com> <2168725.pYTLVKaXyH@diego>
In-Reply-To: <2168725.pYTLVKaXyH@diego>
From: Alexey Charkov <alchark@gmail.com>
Date: Wed, 31 Jan 2024 13:34:34 +0400
Message-ID: <CABjd4YzR6KuqqXQQaTt5Fw_QKwkSf4iaBiM_KXX_sFoD4bNX9A@mail.gmail.com>
Subject: Re: [PATCH v2 3/4] arm64: dts: rockchip: Add OPP data for CPU cores
 on RK3588
To: =?UTF-8?Q?Heiko_St=C3=BCbner?= <heiko@sntech.de>
Cc: Rob Herring <robh+dt@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	Daniel Lezcano <daniel.lezcano@linaro.org>, Dragan Simic <dsimic@manjaro.org>, 
	Viresh Kumar <viresh.kumar@linaro.org>, devicetree@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 31, 2024 at 1:12=E2=80=AFPM Heiko St=C3=BCbner <heiko@sntech.de=
> wrote:
>
> Am Dienstag, 30. Januar 2024, 19:21:15 CET schrieb Alexey Charkov:
> > By default the CPUs on RK3588 start up in a conservative performance
> > mode. Add frequency and voltage mappings to the device tree to enable
> > dynamic scaling via cpufreq
>
> Please add a paragraph describing where the opp values comes from.
> Probably just the vendor kernel, which is fine, but I really like to
> document that these values have some sort of grounds ;-)

Will do, thank you! Yes, these are from the vendor kernel, namely from
Radxa's version [1].

[1] https://github.com/radxa/kernel/blob/stable-5.10-rock5/arch/arm64/boot/=
dts/rockchip/rk3588s.dtsi

Best regards,
Alexey

