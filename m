Return-Path: <linux-kernel+bounces-72196-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A914685B0B1
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 03:03:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DBB151C21364
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 02:03:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 545133A1CD;
	Tue, 20 Feb 2024 02:03:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="WgMAA/ST"
Received: from mail-qv1-f47.google.com (mail-qv1-f47.google.com [209.85.219.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15084482C8
	for <linux-kernel@vger.kernel.org>; Tue, 20 Feb 2024 02:03:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708394606; cv=none; b=EM0j2xFhVTtjtFcC5S+PIMK0JeSGEz8YoRlGhzYrxW3H10y+IlcBs73R16e0FZJH+/ya8d1eqE5qUe5s1T91oyAiaD+1CUgDQzMWc7+VGEjbMs1zo9Jwn3p+XEMFYyq1aPs8fxwGg8wpDTPWg/jo5an925X6kQsuuefceeVqbBA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708394606; c=relaxed/simple;
	bh=Gnb6UeNF8wLVhpCMEWjPwUvIUTFBjSPitOiRpAHZyvo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TCZMJER2EwGhU6luPcxvywvCMLjQdL6KWTSFRG0k75N5yBCB9qUVkby59kwomubf56uOUpPLKKKindLzYeksdcXxCBBbtgT7IA/CKHTEADK6JPrwiGW/Q4Nb9MPCkOTlMCMfloe8m4p8GATJM5/Zb0SZPV12QvvhP7fNOmmURto=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=WgMAA/ST; arc=none smtp.client-ip=209.85.219.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-qv1-f47.google.com with SMTP id 6a1803df08f44-68f01133850so25349266d6.3
        for <linux-kernel@vger.kernel.org>; Mon, 19 Feb 2024 18:03:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1708394604; x=1708999404; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Gnb6UeNF8wLVhpCMEWjPwUvIUTFBjSPitOiRpAHZyvo=;
        b=WgMAA/STiB/qvfjvjrG/jJSQULFr1MXAdizCjimynkmkLV7KrPbwCRuiqj+eFWlZey
         ENK+1pkkxNEnwLdt1jtnWdI/w26SjOALewXfv6MzeG6c3nNYUuMCOcjGHyoC7Ghki3yN
         407vB36XgASQLg716JXns1FdQ1183fA3seAMM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708394604; x=1708999404;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Gnb6UeNF8wLVhpCMEWjPwUvIUTFBjSPitOiRpAHZyvo=;
        b=pGDvwMe/w4raJkQh4AP8qOvMPx6m6Qp/ZxxGivGwHblXiGxU/RWDrKnkCK+/zGKcL/
         2FpBanbyYfqS89QZPePsGONwcIhibAiDedK+y2VOk4Hqvrxrs1KMNSaAwmMBNuVT/NW1
         6kXkKjq8bAptH7VruBLAHe2PJk4CyWNKfRrWvmkI8Q8vZS7mjMHMiyRO49yD7EYErq/3
         /horPJBlm0yn/tpWhdMylypE9owa7k3zaFHjdzxSkfDZJy9yZt7eSt65FvfSGLgPwPuD
         tbMEzE7ZC1j0toKg30OM0MtrDYElKUlKtZoQT9ZLgg7G3IG0awyG5h9P1/QFfmhIJ29i
         dMGg==
X-Forwarded-Encrypted: i=1; AJvYcCVrLLlkF9ehVUE0mzFfk3vO1hi6hSFVK1k460ejm+PRk7O4uKzQz0qWhimn9QXQlaPNz4JqH6ZtG1UGF1uZcHXfCI5vGnNRsB7leBsl
X-Gm-Message-State: AOJu0Yw14iN3CDtO6oMCAxt/aN2iH7X0xop8zpsOHkFNg/SZjtBmgttx
	JZbBipEdWvujc8iQHuX7S55TiiQozhDSuDdAKp0PQKT4+gXccnOd2j/+XuV1kpmz21ntNQ/S3D3
	HCikTIYT3EpO5H3N9ZK1lDKG8S5xQ48WWN22m
X-Google-Smtp-Source: AGHT+IGF6BQP5pn2526eKzx1V1UxSN69r2M8tzxCVxzYihvQCKzBXtYAv8IY9wOCr55gIl0rUtAWPW+D8gzwvDmYkHg=
X-Received: by 2002:a0c:e34e:0:b0:68f:301b:548b with SMTP id
 a14-20020a0ce34e000000b0068f301b548bmr9381595qvm.0.1708394603974; Mon, 19 Feb
 2024 18:03:23 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240202173034.221790-1-sjg@chromium.org> <20240202173034.221790-3-sjg@chromium.org>
In-Reply-To: <20240202173034.221790-3-sjg@chromium.org>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 19 Feb 2024 19:03:13 -0700
Message-ID: <CAFLszThi29VCh2rKzvouW6rSpLq5E=uOzWLASO2-CE3Jw_1NUA@mail.gmail.com>
Subject: Re: [PATCH v10 2/2] arm64: boot: Support Flat Image Tree
To: linux-arm-kernel@lists.infradead.org
Cc: Ahmad Fatoum <a.fatoum@pengutronix.de>, Masahiro Yamada <masahiroy@kernel.org>, 
	Nicolas Schier <nicolas@fjasle.eu>, Catalin Marinas <catalin.marinas@arm.com>, 
	Jonathan Corbet <corbet@lwn.net>, Nathan Chancellor <nathan@kernel.org>, Nick Terrell <terrelln@fb.com>, 
	Will Deacon <will@kernel.org>, linux-doc@vger.kernel.org, linux-kbuild@vger.kernel.org, 
	linux-kernel@vger.kernel.org, workflows@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi,

On Fri, 2 Feb 2024 at 10:30, Simon Glass <sjg@chromium.org> wrote:
>
> Add a script which produces a Flat Image Tree (FIT), a single file
> containing the built kernel and associated devicetree files.
> Compression defaults to gzip which gives a good balance of size and
> performance.
>
> The files compress from about 86MB to 24MB using this approach.
>
> The FIT can be used by bootloaders which support it, such as U-Boot
> and Linuxboot. It permits automatic selection of the correct
> devicetree, matching the compatible string of the running board with
> the closest compatible string in the FIT. There is no need for
> filenames or other workarounds.
>
> Add a 'make image.fit' build target for arm64, as well.
>
> The FIT can be examined using 'dumpimage -l'.
>
> This uses the 'dtbs-list' file but processes only .dtb files, ignoring
> the overlay .dtbo files.
>
> This features requires pylibfdt (use 'pip install libfdt'). It also
> requires compression utilities for the algorithm being used. Supported
> compression options are the same as the Image.xxx files. Use
> FIT_COMPRESSION to select an algorithm other than gzip.
>
> While FIT supports a ramdisk / initrd, no attempt is made to support
> this here, since it must be built separately from the Linux build.
>
> Signed-off-by: Simon Glass <sjg@chromium.org>
> ---
>
> Changes in v10:
> - Make use of dtbs-list file
> - Mention dtbs-list and FIT_COMPRESSION
> - Update copyright year
> - Update cover letter to take account of an applied patch
>

Is there any news on this patch, please?

Regards,
Simon

