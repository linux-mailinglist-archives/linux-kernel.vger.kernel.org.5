Return-Path: <linux-kernel+bounces-59605-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5800684F99E
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 17:29:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1A79E282A45
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 16:29:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D96D97AE73;
	Fri,  9 Feb 2024 16:29:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="zpPyT+KE"
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A22BC7691B
	for <linux-kernel@vger.kernel.org>; Fri,  9 Feb 2024 16:29:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707496152; cv=none; b=Mv5VXt0/P1qcVJw5/P54vNL9HCl4DttmsKoljM1qrC8fntB3pWaZda11VsDUWvNV0wBjxQEPP3CXsqFw2dsI9j4YHRQnTpJO0CX/KQ8bkDEcODKDHRGnBJ7De5EEMTX/Li1cHXYzubogAPywqo9U6usb/4rElKYUGkfv4veP/KU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707496152; c=relaxed/simple;
	bh=kVG4rmAX1MzvfP4plhvh6t2XV6btpWEjQfp2YBQC/uk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZQ3t5XF9sIJHbdZEG4CWHfhuJkiXUr+WtDXQhfSpffR+nmPufjxz8hxNb7XNG+xH8rsa0HCZRa4VxVV2wbOw0Ht8vEQckH+yX/xxvC+6jBSLfnGF5gEpFMzwvKvEX5FWdnH9DLAX392yAJk85du4HhzcqI68Y9pMxDcfER5ogNc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=zpPyT+KE; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-5602500d1a6so1674252a12.3
        for <linux-kernel@vger.kernel.org>; Fri, 09 Feb 2024 08:29:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1707496149; x=1708100949; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=kVG4rmAX1MzvfP4plhvh6t2XV6btpWEjQfp2YBQC/uk=;
        b=zpPyT+KE/FQ7atHuoIHYrwDBrq7V1TK+l+feSZCMu/dy26oCxBAPqsp+Fyb36MNaSr
         nwU6Qw8a/JTR7DY6Lt7UmARff9RajK1rUUERzDZGHxiv9VdrIuaMlbljBMBklTqifmyz
         lqAol8E0kX3X3zceU5DkrwObcr5Q1WpTKoXlL8OmF+TOos11PTrl5Pb70eKsvlcYrZ+r
         F1fJ2TPub+ZRFf0VW3qasvf0xHQRiaZLKPTx35GNdHhmGdzr54QVDqitX90yyIBQ9FGf
         3C13x8+bjV8+unT+VQtYphz5cqXw0Xmd6DPABetaZSn+sGqrm45EdV7fsrWyn8PMq3tx
         AU/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707496149; x=1708100949;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kVG4rmAX1MzvfP4plhvh6t2XV6btpWEjQfp2YBQC/uk=;
        b=nd579rNptietGnMQVixv6+2Fl2VVoRLCcMHZWskrxyv0wvjE2Ay63FclouRJ9gRvlg
         mhUTvT2WBaI4mOmLbhaL0BFDaNeVAwf5y89o14nrEhXpRV0inFp0+0n4hs2LlDi0sFV3
         RLRi/pF+e5+Sue7SstvFHSc8pqYbEjx2DgsPET6dddy79/52nwwAhOUuj8UAqwR/Np5f
         kJmDZoRTJRZLWAe0rEKTofotecw8MbTPhxs4PKgOfTLwHmrW/qH3+V3ZmYkNMtkLaPif
         lCP/h7iypBYtRAPjMVgcEc4G67n3ARlMGHa5sAEb5gsMeusBydx6kwcOpVyhOVZX9+0x
         UtFg==
X-Forwarded-Encrypted: i=1; AJvYcCVt4kY+psLGzDh4HrCUrIe+0qeamTM061+CMJDb3h7+SFamaNTEs2YElpK/QPYhi1okqab7Ge+V71PVz5bLdga0QcoW1Sb8oNf4srOf
X-Gm-Message-State: AOJu0YzOsTulWxRsVwWvs5Bkh0U4kcHTQcSdAGeZJ6nrAko0Zz9vq1N7
	DKKfqFG75skpgziGTTTutAG6IHC/1lpb6sCPB9A3k5aOkFk/29Y3c2DwSy73qizZg8wjgzwZB/H
	tubVWbqHBlF28qD7ClxiVTDNBcGaeHgJzxBTm
X-Google-Smtp-Source: AGHT+IFIjW6afRZSpR9rGbKLm/rdPxyNG0Z79tvHaAuAYu4k5p6b6BVAISbXhE/E21/MzIbNn74/BFd1oyH24+ZmDyE=
X-Received: by 2002:a17:906:2b53:b0:a3c:177d:cb1b with SMTP id
 b19-20020a1709062b5300b00a3c177dcb1bmr43168ejg.10.1707496148741; Fri, 09 Feb
 2024 08:29:08 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <38f51dbb-65aa-4ec2-bed2-e914aef27d25@vrvis.at>
 <ZcNdzZVPD76uSbps@eldamar.lan> <CADKFtnRfqi-A_Ak_S-YC52jPn604+ekcmCmNoTA_yEpAcW4JJg@mail.gmail.com>
 <1d4c7d06-0c02-4adb-a2a3-ec85fd802ddb@vrvis.at> <CADKFtnQUQt=M32tYhcutP0q6exOgk9R6xgxddDdewbms+7xwTQ@mail.gmail.com>
 <CADKFtnQnz0NEWQT2K1AGARY5=_o2dhS3gRyMo-=9kuxqeQvcqQ@mail.gmail.com> <cf6b1264-8639-46e7-8dae-5aff0306e958@vrvis.at>
In-Reply-To: <cf6b1264-8639-46e7-8dae-5aff0306e958@vrvis.at>
From: Jordan Rife <jrife@google.com>
Date: Fri, 9 Feb 2024 08:28:56 -0800
Message-ID: <CADKFtnS3gkGWfwD80intR906y4Hn39WHOraY65mFtqzE_-iMyw@mail.gmail.com>
Subject: Re: [regression 6.1.76] dlm: cannot start dlm midcomms -97 after
 backport of e9cdebbe23f1 ("dlm: use kernel_connect() and kernel_bind()")
To: Valentin Kleibel <valentin@vrvis.at>
Cc: Salvatore Bonaccorso <carnil@debian.org>, David Teigland <teigland@redhat.com>, 
	Alexander Aring <aahringo@redhat.com>, 1063338@bugs.debian.org, gfs2@lists.linux.dev, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
	gregkh@linuxfoundation.org, regressions@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

I sent this patch out to stable@vger.kernel.org. Everyone should be
CCd. Thanks for your help in confirming the fix works.

-Jordan

