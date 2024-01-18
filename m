Return-Path: <linux-kernel+bounces-29609-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 50DA48310BB
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 02:10:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EFF871F24F41
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 01:10:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F00C728FD;
	Thu, 18 Jan 2024 01:10:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=umich.edu header.i=@umich.edu header.b="OdafvZq4"
Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72F1C1FAF
	for <linux-kernel@vger.kernel.org>; Thu, 18 Jan 2024 01:10:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705540244; cv=none; b=iyb9W63DHsWoCySVwicwxc2BVlcPYTm1ARUn6gcuMMHp0/JrNkgsVZAsvZyW8JlmYLyw3YRtYQm34Q+ZKOx9AwIVa+NWYCfiRPmQlaDlOCoApp+2JXSLT/27cim+BLispPPjq0XGMNBHOFzE8ZbzOIeOlxLunJVmuuZNtF5Ecn8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705540244; c=relaxed/simple;
	bh=F0iHv+YiAEtc5/usoROQkGtoDZrBFE4pjqini4BdYMk=;
	h=Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Google-Smtp-Source:X-Received:MIME-Version:
	 References:In-Reply-To:From:Date:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding; b=S7qJWRFRbjH3RH8DJ7jhgubzvIU2AnIG8D5PkXTgExVyzQkUuDM7PauIgSoBfysJHaXuLbNBJhrua57yfZNGc+w0Qgxjze43BHJNQ3ncdFi4smzPZbaDbKUM90HBfXmsvFcsDz6t2YJigcRn5rqHLnDOiB6HiUWvUp8PHIUEvpg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=umich.edu; spf=pass smtp.mailfrom=umich.edu; dkim=pass (2048-bit key) header.d=umich.edu header.i=@umich.edu header.b=OdafvZq4; arc=none smtp.client-ip=209.85.128.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=umich.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=umich.edu
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-5e784ce9bb8so2154367b3.0
        for <linux-kernel@vger.kernel.org>; Wed, 17 Jan 2024 17:10:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umich.edu; s=google-2016-06-03; t=1705540241; x=1706145041; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=F0iHv+YiAEtc5/usoROQkGtoDZrBFE4pjqini4BdYMk=;
        b=OdafvZq4IByq2Lqza9sffITdY0hKEWOPBqXTsWoR+fxmOXhfhD4liEeXc+6pF5d8RA
         S67enbJ8ReVY+1t8n0iAZj9l6Zm5wa1w8het/wDHg9h+D6nLeyMNNEY2dvtNXPEVrrRc
         zfg4ijRGuuvhPJGwAAA32HX0acudHeJWxsQJJPrPCxQieQumet9rmM42bkaHmyaNJUvv
         eU1QP/JwPE6RviWS0UxFwWRS8Whxe3dmDnX3cP1i1zCk/w7Nkk3die/2w4trATnURYOb
         cx9aMv85FoEnkK/1nGe2HGk6E3ZdVyKUGDnzuhKBBGXYaSaGsLLqtAPs9wCAAuIPCpXR
         D65A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705540241; x=1706145041;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=F0iHv+YiAEtc5/usoROQkGtoDZrBFE4pjqini4BdYMk=;
        b=Hi80lTNvCfOBFClY2JijU7SxWDhvg40Fr9dWZZUcI7oWdjWc4R5suFM9+mi0NdS2Oj
         7pTxBrzP308Om2+avUwwsArGEsaCAZd5rYvQYcNYlVq4yMedV9m6PIUR0G4zv5cpC+QK
         TDZwarFExNdvx/reI273CzYYDTAUxl77TwxIm2fZeuDb17KaSOHGqZ0fZxAW0nMV3Q5b
         xtunat7mkf6mD8chdVLLxYpZzkaxwHeVoiueuXyoIC0lC/L26YiPZWhWQ6GeUa5H294U
         itGnwxG5UYvs9hzcrjBUJ54czOHijFlg4EWXn4auWqOI8bb7Fur425IcDzJVvRJerGzM
         FuoA==
X-Gm-Message-State: AOJu0Yz0e+1g7kZVgX26QfbGana+R/t5iOTBQWLZJ1P8UT7hj4AGc375
	Z5U/eczw+SPPCUt7qY+KOKxXLsddP7HZRJ2ovXAPDmcFQjTJqXR3V27RnFEkMt3BeqsdieNLk28
	XUApMyLn5QZQeGVwcp0H3wDJRMKrHEKFM2pHD6g==
X-Google-Smtp-Source: AGHT+IHRW34NuVAmIMoJ9ZjcnCcEJmU6dQHelPA36vDFGW/Swb+NJiCS+hZXnZPiFfOGQ+RWOclRm1P9Q5gR04Q1NCc=
X-Received: by 2002:a0d:e4c5:0:b0:5ea:1ea8:9ca1 with SMTP id
 n188-20020a0de4c5000000b005ea1ea89ca1mr118594ywe.43.1705540241466; Wed, 17
 Jan 2024 17:10:41 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240116160141.165951-1-kernel@valentinobst.de> <20240116230951.168808-1-kernel@valentinobst.de>
In-Reply-To: <20240116230951.168808-1-kernel@valentinobst.de>
From: Trevor Gross <tmgross@umich.edu>
Date: Wed, 17 Jan 2024 20:10:30 -0500
Message-ID: <CALNs47vXx+PSm_ym2Kytj5MM51jTkLnY0VGgUXcYb9a8kuQBXA@mail.gmail.com>
Subject: Re: [PATCH 08/13] rust: kernel: mark code fragments in docs with backticks
To: Valentin Obst <kernel@valentinobst.de>
Cc: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Wedson Almeida Filho <wedsonaf@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@samsung.com>, 
	Alice Ryhl <aliceryhl@google.com>, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 16, 2024 at 6:10=E2=80=AFPM Valentin Obst <kernel@valentinobst.=
de> wrote:
>
> Fix places where comments include code fragments that are not enclosed
> in backticks.
>
> Signed-off-by: Valentin Obst <kernel@valentinobst.de>
> ---

Reviewed-by: Trevor Gross <tmgross@umich.edu>

