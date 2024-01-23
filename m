Return-Path: <linux-kernel+bounces-34599-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 95D1C838249
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 03:19:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C8BCC1C27435
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 02:19:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFB7C5A788;
	Tue, 23 Jan 2024 01:43:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="m9XU2+pd"
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C39755A0F0
	for <linux-kernel@vger.kernel.org>; Tue, 23 Jan 2024 01:43:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705974192; cv=none; b=l/VzV6l2JzAgk+OpRiBWNRviKnjt4KhcLHosGzNpJxI23mPDNoU2ITtwaKSATFwdsUgug+JxmtUbYQFehaiBpwBpZgYk6H29SFR2EqfsnX+l6yRKeqfDwuNeyag/xS3DtQ3kr+IcDTXzeh0LmWf+D+Dv/YvthiYmLtJ26FgYcWY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705974192; c=relaxed/simple;
	bh=us2Nn2QhehUcUTgQCyXDLmshMnzudxu82UJCK2o/+eU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=f1BHNPEAHCWvPBeGy2fENHabP3u09hCWxFwY2NwzlOO2EpFeJMy+JdYTRdrSYdd1IjljlQci9g8HseX13i4NWVOFhxI+rSdMZWmh3/Pigdw8rxkyrm6m4sAkXjQ7/6z/DORkhFhgSoPpKrw8xTeLlyJE0D+nezzNI+x2SK8WNiU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=m9XU2+pd; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-1d7431e702dso11001725ad.1
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jan 2024 17:43:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1705974190; x=1706578990; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hG6Zz0zVEjv/vq4/O9G85IGM9ihKf6mRCUIfdafBGsU=;
        b=m9XU2+pdNb+l1luX1VURqfczY+1gA3NCV6LHzRWsS8doWyD4JB7AO6JCl9sZSYqJg9
         ymhfUsxJaZ8tcFz5PV7iQmHMDYfrtEP9WNOBAbaBAiB0Ek7HBPC+n1PINbRvOIG3nPPh
         3z22ecwEe1nPrZ5xRHe2W14QtWdGDi4pmuJ8U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705974190; x=1706578990;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hG6Zz0zVEjv/vq4/O9G85IGM9ihKf6mRCUIfdafBGsU=;
        b=HxDL1NKhDxFmc0MsPwX+xvlLBAB4bMfI4x343FRzxZell9iwsCkS7AA6c0BN0MejB5
         31vcndM7iiaRpio7PVrhh36/p+yTfb/cRBas6GnqGFdlekYMHnqAnWRnPRrh6kY16Cy6
         60VLI3MaozMT6ny/kNZDobiPakTKZouUjcc3iJYi1+sosCdZeYn3a4Yd1dBvHlF7L8XB
         AztZ3pRyAMy+ltN+bcyk+5nQOguzcR7hPGG0Xv0zEMW8tOcHnGxsUC8gfHw/HliO+ZYT
         sEFvXJ3awYYzzbhsVBCuycCrVxHml4oU6SYpwjwRlangCkKwEXkilY56Q1pLlMEDNljg
         RNzw==
X-Gm-Message-State: AOJu0Ywq6oDx3CHdw4uDpIg2AoJLz8HeAPCod4IQ2df49BA7g5HbMWTW
	DxmTp7/zz4kGxIQ9n0ajMEAAkLUwL88G3esivy1kapqxfViPuLDeQ6CQrL2oiQ==
X-Google-Smtp-Source: AGHT+IGENlFp1To64uOApGgxIxJKdJI4/yv9ACT2mUyVj6c2Y2Qp28vsJK2xe7bPZS+fcx9BQ04rGg==
X-Received: by 2002:a17:902:ab84:b0:1d4:261c:d03e with SMTP id f4-20020a170902ab8400b001d4261cd03emr2076408plr.123.1705974190054;
        Mon, 22 Jan 2024 17:43:10 -0800 (PST)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id t1-20020a1709028c8100b001d7505a6894sm2483397plo.230.2024.01.22.17.43.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jan 2024 17:43:09 -0800 (PST)
From: Kees Cook <keescook@chromium.org>
To: Douglas Anderson <dianders@chromium.org>
Cc: Kees Cook <keescook@chromium.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] lkdtm: Make lkdtm_do_action() return to avoid tail call optimization
Date: Mon, 22 Jan 2024 17:43:04 -0800
Message-Id: <170597418226.1430560.6759248448466704119.b4-ty@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240122164935.1.I345e485f36babad76370c59659a706723750d950@changeid>
References: <20240122164935.1.I345e485f36babad76370c59659a706723750d950@changeid>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Mon, 22 Jan 2024 16:49:34 -0800, Douglas Anderson wrote:
> The comments for lkdtm_do_action() explicitly call out that it
> shouldn't be inlined because we want it to show up in stack
> crawls. However, at least with some compilers / options it's still
> vanishing due to tail call optimization. Let's add a return value to
> the function to make it harder for the compiler to do tail call
> optimization here.
> 
> [...]

Applied to for-next/hardening, thanks!

[1/2] lkdtm: Make lkdtm_do_action() return to avoid tail call optimization
      https://git.kernel.org/kees/c/189a4edb774b
[2/2] lkdtm/bugs: Adjust lkdtm_HUNG_TASK() to avoid tail call optimization
      https://git.kernel.org/kees/c/edb6538da3df

Take care,

-- 
Kees Cook


