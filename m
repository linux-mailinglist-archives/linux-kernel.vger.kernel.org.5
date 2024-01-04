Return-Path: <linux-kernel+bounces-17105-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E364824861
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 19:51:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BFDB1B24972
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 18:50:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BDDD28E24;
	Thu,  4 Jan 2024 18:50:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="M5GeHsjO"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22BED28E09
	for <linux-kernel@vger.kernel.org>; Thu,  4 Jan 2024 18:50:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-a28fb463a28so49978266b.3
        for <linux-kernel@vger.kernel.org>; Thu, 04 Jan 2024 10:50:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1704394246; x=1704999046; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=XxCIeQ9j4EehMbMWWRhFVXo20FPclvu+h4tS5qZG5ug=;
        b=M5GeHsjOPyRCFdI+6KNsXejVrQqcBitHhXnA/WZ1BLwt6w46rx90tENrYHrvJDr8Ev
         R7oJTbQSiYHmdtjWwR8bztxs3bgw8kWHB43RRDxdEA5Tynn4zf7E7hm4gF2fRBkbwNcC
         x1L/XRF/jQ6dSf/wrPgCkdJVTKWqKFN9ETwXA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704394246; x=1704999046;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XxCIeQ9j4EehMbMWWRhFVXo20FPclvu+h4tS5qZG5ug=;
        b=K54SAkbdHnT6UyWmllybIgNzL65FTYhps410zXKbPDc0NgcsXrsOzAspq5dq1Soidp
         T+9SSoq38SKcyfBBW5SnqBzl9OG3CnjLxlG9BHTHdVc8e1zvBzKsknQ/GQuJRuJOCgyu
         ZKxi7gR+bzymYA1MS7Jv31NIaU1zEMo5Hiy3Z14uH+rTZYGNK9vKBngvXx53Aj2Juytm
         cPrItUZeUeiZyzNoO1uzT+ogMf3D4O6YD1dtO0imRaQOfpTIdoOA4NH7l/TNmJTV3jXU
         aEZv0cYQ5gf9hOcldkyuTiYl+DN70RDbQqd/dMACD47BS67zvdxlmx9ve3+WO3W6kwLw
         qDWA==
X-Gm-Message-State: AOJu0YxX+su0QIowQvg+9+LIPbWo+1+eSmEti3eStrR05HFUQccz4nc6
	QWhFCitsHJWX0WamCmE2UFba6T/2BcBF6fPqSBkpctK/FX0xMMNe
X-Google-Smtp-Source: AGHT+IGN6bkZdymB8QSG8sW+lmb2V7EKyPkykE2BqBrhUHNQqCW16vGxbTdQ63vQBRJ3ljR9IFpxpw==
X-Received: by 2002:a17:906:7856:b0:a27:5446:27d9 with SMTP id p22-20020a170906785600b00a27544627d9mr598726ejm.5.1704394246103;
        Thu, 04 Jan 2024 10:50:46 -0800 (PST)
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com. [209.85.218.43])
        by smtp.gmail.com with ESMTPSA id vz10-20020a17090704ca00b00a269b230c0esm14034343ejb.34.2024.01.04.10.50.45
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 Jan 2024 10:50:45 -0800 (PST)
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-a28fb463a28so49977066b.3
        for <linux-kernel@vger.kernel.org>; Thu, 04 Jan 2024 10:50:45 -0800 (PST)
X-Received: by 2002:a17:906:897:b0:a28:b7e2:15b4 with SMTP id
 n23-20020a170906089700b00a28b7e215b4mr427985eje.88.1704394245242; Thu, 04 Jan
 2024 10:50:45 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAPM=9txBXQR8YsaU2fO1frcGBP6HKTF473Rqae_hwT_yY-dRrg@mail.gmail.com>
In-Reply-To: <CAPM=9txBXQR8YsaU2fO1frcGBP6HKTF473Rqae_hwT_yY-dRrg@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Thu, 4 Jan 2024 10:50:28 -0800
X-Gmail-Original-Message-ID: <CAHk-=wg26tNyaOE5jAcEg1t_zK37mHXqJN9nzmYDA3dN_WO5kw@mail.gmail.com>
Message-ID: <CAHk-=wg26tNyaOE5jAcEg1t_zK37mHXqJN9nzmYDA3dN_WO5kw@mail.gmail.com>
Subject: Re: [git pull] drm fixes for 6.8
To: Dave Airlie <airlied@gmail.com>
Cc: Daniel Vetter <daniel.vetter@ffwll.ch>, dri-devel <dri-devel@lists.freedesktop.org>, 
	LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Wed, 3 Jan 2024 at 18:30, Dave Airlie <airlied@gmail.com> wrote:
>
> These were from over the holiday period, mainly i915, a couple of
> qaic, bridge and an mgag200.
>
> I have a set of nouveau fixes that I'll send after this, that might be
> too rich for you at this point.
>
> I expect there might also be some more regular fixes before 6.8, but
> they should be minor.

I'm assuming you're just confused about the numbering, and meant 6.7
here and in the subject line.

This seems to be too small of a pull to be an early pull request for
the 6.8 merge window.

               Linus

