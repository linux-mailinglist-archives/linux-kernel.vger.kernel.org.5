Return-Path: <linux-kernel+bounces-59980-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CD3A84FE25
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 22:06:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9EEE61C2267D
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 21:06:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C42611B268;
	Fri,  9 Feb 2024 21:05:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="xkE/m40j"
Received: from mail-qv1-f52.google.com (mail-qv1-f52.google.com [209.85.219.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C42F175B0
	for <linux-kernel@vger.kernel.org>; Fri,  9 Feb 2024 21:05:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707512754; cv=none; b=l0fYufo8UpMzA3XN3XF7c7xAXe4nZjcVroguyEHFrTxuLKwufXH7khLepRK8ir4GUrM9TmECS4eR5JAM0byPqjEtlpsEUZiqvy4TUDS+v4JG97lLAVK6C81eBebgfvYqox+PWttlYBmxp1HkkZf2EuMRAgRgfIHpOyiN9vDzpLM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707512754; c=relaxed/simple;
	bh=fWX8AY1UCsAO7A9Rl5Srx2ebyrVS3CEaNUQK2IZKBWw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZRy5tQG4qjEILBdN+Ej5BVt0+uG9I1vk9fsBqVgQ1nCke96oLV7+3mAQ7cCt7h3gIVJ3Y0JBk5n8iZBqmJVSb7/cUxjw+pkkzoFmUGowyuTU/VFiP2s/Bumd5hDlslHay8rzYAHiO4525BwQiaxk0jmFixkG4atnEHh+livpOuM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=xkE/m40j; arc=none smtp.client-ip=209.85.219.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qv1-f52.google.com with SMTP id 6a1803df08f44-686a92a8661so6053266d6.0
        for <linux-kernel@vger.kernel.org>; Fri, 09 Feb 2024 13:05:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1707512751; x=1708117551; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fWX8AY1UCsAO7A9Rl5Srx2ebyrVS3CEaNUQK2IZKBWw=;
        b=xkE/m40j0myteCeuAXkuUT8lnEN4ct8CDu7mmbTDAT1CMQe3r8is3167wYTJir800a
         R9UEZtfTDZiHt0/ODAi5VOq3Yc8qvvj2hrWM0CbENgWjHiJrWUxT/eHp8lYE6/XfqpHJ
         WkuxnKVBcpgvMMpQNICP4WP0PqNZuiVNU6AyEgzk2uYlwxb/Jit5huKkYxsjbtYFKgNO
         R8UB/BB8BfvKb21FK253U3NJiSyfJjddJySGbHFoU1KDKAznofeogDLpWLzQ5yOVedoG
         m8+cx6f20TCO8lyhoop27z4JFeHtNMSPCj/LJDufWD9yTCSI+kiunMtlPP8onE6zn53b
         k6eQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707512751; x=1708117551;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fWX8AY1UCsAO7A9Rl5Srx2ebyrVS3CEaNUQK2IZKBWw=;
        b=gQZizHXjxveTbu4EBeRWcyvU5Y4KTK5+2TM4STCf6PZXjly0ZRfPVKrZGk4IpV64T/
         KJB9l7kVjcHPPhucrMCY/8U5lr5LszzG6pwzhd4zCUeQW7bID1dcrESw6ddDotwf3AaB
         Sg967bmioYUz1UfAHvdHDdDn8SL+UV5Oj5J0EG8KxrQ8moFJC/HBZryHLUh4sSvm6k4v
         eDp47NduZdMZwN8pujg0Lp7PGcKs/jLqrH12Fe0XaTU+IGV+rroKqXDl4mgW6BpcAqup
         8JdGoexrrwykZl+LzxLHJXVSb/5QDvsRCEFdtDkt6ZMdfno26tYtyjEVphL8/XfJvDaU
         nvxA==
X-Gm-Message-State: AOJu0YxvrqZYasutsJGdohMK0ZRVWUE4x7nWvUkhbawzsjMTBUL1Gw6V
	cmReahrtzVT0WFqr9m505Uq7stFsMFGSfKtTqW/apFvPx5b1IVFd9f5fi/SGkR2/gEn3rv6Cf0Z
	u2gT8xtgGCj2GP6DsBRmUezYGtHK9m+Zj6Jsq
X-Google-Smtp-Source: AGHT+IGs5gOcnQQd2dq5dd2RpG8BY/CC0Qys6/UWioQgwTa/o34PsoRm6jC/jXHj8ljZ3lVgAqg4J2Flc7+R3ljGXEQ=
X-Received: by 2002:a0c:e351:0:b0:68c:bf1d:70ca with SMTP id
 a17-20020a0ce351000000b0068cbf1d70camr354954qvm.43.1707512751398; Fri, 09 Feb
 2024 13:05:51 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240201044623.374389-1-aahila@google.com> <ZbuEsltcMLNn4SyF@smile.fi.intel.com>
In-Reply-To: <ZbuEsltcMLNn4SyF@smile.fi.intel.com>
From: Aahil Awatramani <aahila@google.com>
Date: Fri, 9 Feb 2024 13:05:39 -0800
Message-ID: <CAGfWUPxLVzziWmwcfqDCfWuVM_Gjya4AzTmoqs1xTcGMXsRorA@mail.gmail.com>
Subject: Re: [PATCH 1/2] dt-bindings: i2c: designware: allow fine tuning
 tuning waveform from device tree
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: David Dillow <dillow@google.com>, Wolfram Sang <wsa+renesas@sang-engineering.com>, 
	Andi Shyti <andi.shyti@kernel.org>, Rob Herring <robh+dt@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	Jarkko Nikula <jarkko.nikula@linux.intel.com>, 
	Mika Westerberg <mika.westerberg@linux.intel.com>, Jan Dabros <jsd@semihalf.com>, 
	linux-i2c@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Thank you Andy and Krzysztof,

I think you are right and I can use the other DT counter, I am
currently trying to test if they work for me.

Best,
Aahil

On Thu, Feb 1, 2024 at 3:49=E2=80=AFAM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> On Thu, Feb 01, 2024 at 04:46:22AM +0000, Aahil Awatramani wrote:
> > The Synopsys i2c driver allows a user to override the parameters
> > controlling the waveform using ACPI; this is useful for fine tuning whe=
n
> > needed to make spec compliance. Extend this support to the device tree =
to
> > allow non-ACPI platforms the same capabilities.
>
> DT has different counters from which one should derive these ones.
> Can you explain why existing bindings may _not_ be utilised?
>
> Without this very justification, NAK.
>
> --
> With Best Regards,
> Andy Shevchenko
>
>

