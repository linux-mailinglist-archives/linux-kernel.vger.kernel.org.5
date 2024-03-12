Return-Path: <linux-kernel+bounces-100030-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E5B64879109
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 10:36:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 74274283AD3
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 09:36:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEE2D78270;
	Tue, 12 Mar 2024 09:35:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HttZYhhP"
Received: from mail-qv1-f45.google.com (mail-qv1-f45.google.com [209.85.219.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE8FB77F32
	for <linux-kernel@vger.kernel.org>; Tue, 12 Mar 2024 09:35:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710236155; cv=none; b=UPJ/LTM+SmV4nKMzXyhMVlYglpRVeM7bDDIxGzRDsOQMI+MbuY0AJnSoAAIbEzPv7HWF/BqgI9jLJFBWRZ/JhHVG0diSbf59fvz3AXbTgEaOZUDtSIjTgTj0zV7LkCQgyF+sEGkvrKFavrYROQ+8FQtqQQD4tKTBdjGxYjRJGDw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710236155; c=relaxed/simple;
	bh=ljOGSIOwEPVM9aUkLHCpa36SGLC+SUxtQAmTIrQTJdc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=H337xqoK7ERtLdd0iliIO8bptUNrkponrVuDgevp/tZehousXi8Nj4Pp6DvvM1qosUyCJKWZleLUOL/dOhTSb8uUs3uRD/Hkfrogrh9LpIvdl0/3Zy9B0LBNKLh+6YRIkUz6TzSrp/Xy3unZeBiDENbPF0J59EZVAWLn4dpBZXE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HttZYhhP; arc=none smtp.client-ip=209.85.219.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f45.google.com with SMTP id 6a1803df08f44-690ddcd97dbso7768926d6.2
        for <linux-kernel@vger.kernel.org>; Tue, 12 Mar 2024 02:35:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710236153; x=1710840953; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ljOGSIOwEPVM9aUkLHCpa36SGLC+SUxtQAmTIrQTJdc=;
        b=HttZYhhPVCAbwG7SBePa1JM276nctyn402gS8eZrqXRMGAPCj4wui6HW06C2oypFhI
         FvL/5F0u7MKKrFm0pheuSKMg7cZh4WHzy/jgO8Xazyn6xYKvf52Z2z8j8QyWKD+bcsCQ
         cHCEx5G/mOQRLN5O9u3cdPLMKjJjLUYlOMK68zsWT+xnrfrGig5JPh59r/kVBIEMTFqJ
         lT1mby9bXZ6fUI4hn5DWQrQdMhZvWC9ytOfFIHxdfiq5deURIsEcLqnzxJFzM/JKEm6/
         fhQVMtqdW+d3hQc2ph2BODRni7vTL0+TkmmLXuBU/jvzh8WdUGdFKQ/h5slZLLgv/jiQ
         TMOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710236153; x=1710840953;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ljOGSIOwEPVM9aUkLHCpa36SGLC+SUxtQAmTIrQTJdc=;
        b=FNYZz0CbRfSYiMpb39lSvZRJZ9QKZRdbdjz/jTuw0zvxKum1EAOv0jCyNoHpdY3Iy/
         z4bDOK+vbj2T2FXj/HZDYaWcRW/GH1y7kIbcFIZPxG4bfsb75Gw8KoEtMnVCc8KCpHxa
         Yt2tRkmrADGFewnoDk6dl6N/5v8zu1ZymUDP/AxnnL2ngfbeRhkYOB41F+3Zz25W3DXA
         iMqldwDNfNTvor5jePPpUP2NuvUHqUKO4XZUsBQNIc2y1p4UIoXtqZc8mC+LoZJf56vT
         w4hqAqg088bCddDBFwJm22cF+JWKCRx1DKn/tg+4HkDK8IuC1dkiYu4JGmAwV5BTbs7C
         +sEA==
X-Forwarded-Encrypted: i=1; AJvYcCXQl+yO7G7RncrVFI6HkCVi16LUaWHUc8MuaDnAPJJfM2lZiFbobuaQOC7sOW3Y1vx1YMRYUIb/iB1ZHoDjyjqaPt9+L/nsUeKcy3vW
X-Gm-Message-State: AOJu0YyO/CzrUMlAjLXOIEgv7KvYhn3dcfSxE0kCT/kZtPFepYJaVCPX
	78VnUzQXxf/Hm8ZL8t0kae3ZF4sdDTPombdSovIj3dveXXr1RKYP3bBAmt4Z3Sh96YcIR7gUfka
	t+OqkwAjKm05AjgBp5dw7tFR1c/A=
X-Google-Smtp-Source: AGHT+IEOz3HLcenDvdObsuH5wsmDw9QCUbs4wzbzF9oUlUobqOUbF51k+0xv8+XEDYB8aSqIM7pWOaajyEOWov03HIg=
X-Received: by 2002:a0c:e286:0:b0:690:bf98:cdc1 with SMTP id
 r6-20020a0ce286000000b00690bf98cdc1mr8704861qvl.15.1710236152805; Tue, 12 Mar
 2024 02:35:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240311235210.2937484-1-yosryahmed@google.com>
In-Reply-To: <20240311235210.2937484-1-yosryahmed@google.com>
From: Nhat Pham <nphamcs@gmail.com>
Date: Tue, 12 Mar 2024 16:35:42 +0700
Message-ID: <CAKEwX=Oaj=h-Lqk+ZdrB6LpksKF5xhNJkpgUuF-wQ0gk6+pgpg@mail.gmail.com>
Subject: Re: [PATCH] mm: zswap: remove unnecessary check in zswap_find_zpool()
To: Yosry Ahmed <yosryahmed@google.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Johannes Weiner <hannes@cmpxchg.org>, 
	Chengming Zhou <chengming.zhou@linux.dev>, linux-mm@kvack.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 12, 2024 at 6:52=E2=80=AFAM Yosry Ahmed <yosryahmed@google.com>=
 wrote:
>
> zswap_find_zpool() checks if ZSWAP_NR_ZPOOLS > 1, which is always true.
> This is a remnant from a patch version that had ZSWAP_NR_ZPOOLS as a
> config option and never made it upstream. Remove the unnecessary check.

Do we need a Fixes: tag for this? I guess it's not a bug hmmm.

>
> Signed-off-by: Yosry Ahmed <yosryahmed@google.com>

Reviewed-by: Nhat Pham <nphamcs@gmail.com>

