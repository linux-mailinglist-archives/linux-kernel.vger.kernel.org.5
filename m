Return-Path: <linux-kernel+bounces-120696-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 045D088DB8D
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 11:50:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AF6711F28358
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 10:50:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 659F4524B2;
	Wed, 27 Mar 2024 10:50:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HaCmLsTc"
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3FE94F1F6;
	Wed, 27 Mar 2024 10:50:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711536612; cv=none; b=XV/exygPBRpNU/KjwLuuwErhl0ZuCe6DpXE50gNW11nTMN1oRUzmvo/HHQzfitc7TlY6NaXRvk+1MlVMKKOZegCifVBn/G4e08Jm7BypHKlyE+liizFk52qm2Sy111JrUFl6W+lv3xM/dZDsC7aNMy0AfR9LaGHYFsZkqduYD/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711536612; c=relaxed/simple;
	bh=hRZ12UFk01NEt79oTtxQRbJ/1y3rDaUGFfV1INmoIGs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=t6pxmjFk29GASNcJrywbIplgb0UOZVj48gG6ZQmtNJ5tGUNdTA4q5PzwRmvzaofjiLGWpUxdsrgrJ47UAMGNEdu/MTRyPBImjmUrHQPETuZW7u2EcPeaC1jLnILQzSaLs28Jrpaz14SWV9G0QvKm/4x25QI9m7f86OdpLXRsLnk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HaCmLsTc; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-6e6f69e850bso5946943b3a.0;
        Wed, 27 Mar 2024 03:50:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711536609; x=1712141409; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ture+LxIapYu0oPV7sdPwmJ6Rv+cKuHE663qPdR1ILM=;
        b=HaCmLsTcoS6LBlwQ9LXTkoM8GwzAje0CXnAhQywu2SBc+URjQ99rna6w7cXJFYuGVI
         r9FFlrbBMZWjmiYBIign2wJ/IFwbWTYrPGJ+1+SD6usodQNkBAuiAvqvi9R371N0PTDw
         w5jp3tykqXK42qdSjjryJqxMxDmVcQdq14MzDPxK3W49E/rKiFW5cOn1gSqMuWgnstzs
         i4D1Jz9DVt0bjOAR5TBxFcWFM7qjnc9cAM361cGimNz+4S17wGEl0DXW561wEgxHav2i
         KIhN8hueU/juFLNOc9LDdI4srYn69i/2LrQR/7QE73WFS8QDcSVNxEXtPTSRFAsn++a4
         SuzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711536609; x=1712141409;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ture+LxIapYu0oPV7sdPwmJ6Rv+cKuHE663qPdR1ILM=;
        b=UrxkFq3Ic/QOuHou143D+t8tpB7rW2wvEFlnQY4/yDCEqFy5piArnt5zYtR1r7DIpv
         xkvorWYxWaZewJg8mVTTisvWkmIqCxTthMhUS/6rzm4jxrGgxImvHUvFTdWqiCFhlGvX
         tLB5PdEopqqSbI9x9onOZwxxFMOIH8yzbN4OfWQIlgvZqMtlvsRXCJSfKQifdw41b/de
         tZq1q1CnBkfvccZhSnd0c+dMeNrRnYZTJhdJd8MTIDs6AtpdCXrl0GMWKeIQo0tOixkp
         ZERiSq0FFDtZVuT0TSg2bhi78B3tGg9hm6TnNP4dJpkES2n1EGnwoIJCVyw3kUCf+uIe
         fzYw==
X-Forwarded-Encrypted: i=1; AJvYcCWEhzdDC6J16T/pvmKmFAQkLC2mhKw2yCgXtDpImJHSkSg+C1VUrAUdwyvvdvoBfEzdGHLqg998ISb3iLzAN1X6rJmyf0W0SVgyW1IkNBguiz7wa2imYhneCsfT1OOnzCK/tSIyYwHEPIg79go=
X-Gm-Message-State: AOJu0Yz1pLkdpuLGhil/My6NRo/wObT0jKsrw6Pn6uWJ3lqr3VQOkg8J
	xVST3GEgUqPPUxYVIxC4CynxXTrSaBlft8jspUcamR21dnBs1XK82WbVzqIF1Lg9pcd4kIEh/GT
	raWeou9g6i+NgsX5OkoWwr7hmvNw=
X-Google-Smtp-Source: AGHT+IGJj/bSZAP3EjL/JWUjRKPP2j3anmA/ZNQuHSO9LvWflS1OwWtEtEuC5q5HpCiPQAhY9CM7STns6XpVssCEc7U=
X-Received: by 2002:a05:6a20:7351:b0:1a3:c4b9:dbd9 with SMTP id
 v17-20020a056a20735100b001a3c4b9dbd9mr3971300pzc.42.1711536608991; Wed, 27
 Mar 2024 03:50:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240327023531.187880-1-wedsonaf@gmail.com> <20240327023531.187880-8-wedsonaf@gmail.com>
 <ZgOXGSDmIgrENB7d@Boquns-Mac-mini.home>
In-Reply-To: <ZgOXGSDmIgrENB7d@Boquns-Mac-mini.home>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Wed, 27 Mar 2024 11:49:41 +0100
Message-ID: <CANiq72=0Q2KJ_Rmnsa596fRA0E3tE4cZtG7W7DHU94=nWLMoSg@mail.gmail.com>
Subject: Re: [PATCH v2 07/10] rust: alloc: update `VecExt` to take allocation flags
To: Boqun Feng <boqun.feng@gmail.com>
Cc: Wedson Almeida Filho <wedsonaf@gmail.com>, rust-for-linux@vger.kernel.org, 
	Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@samsung.com>, 
	Alice Ryhl <aliceryhl@google.com>, linux-kernel@vger.kernel.org, 
	Wedson Almeida Filho <walmeida@microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 27, 2024 at 4:48=E2=80=AFAM Boqun Feng <boqun.feng@gmail.com> w=
rote:
>
> /me likes this! ;-) Too bad `write_slice_cloned()` is not stablized:
>
>         https://doc.rust-lang.org/core/mem/union.MaybeUninit.html#method.=
write_slice_cloned

For future reference, it will be called `clone_from_slice` soon (1.78):

    https://doc.rust-lang.org/beta/core/mem/union.MaybeUninit.html#method.c=
lone_from_slice
    https://github.com/rust-lang/rust/issues/79995

This could be a "good first issue", i.e. to replace these if these get
stabilized (which seems likely).

Though that one has to account for panics -- it would be good to check
codegen if we do replace it.

Cheers,
Miguel

