Return-Path: <linux-kernel+bounces-100122-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2661987920B
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 11:30:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A87C1284328
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 10:30:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A42178695;
	Tue, 12 Mar 2024 10:29:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mbEqhKC5"
Received: from mail-vs1-f53.google.com (mail-vs1-f53.google.com [209.85.217.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5702348CF2;
	Tue, 12 Mar 2024 10:29:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710239394; cv=none; b=DpyOrThhX4/goRXK/uHe2+chO73jYBnha8vPgNXHyREOAReBAwv0wXk+8qLw43s4viwQhso6PURCmRNVHW5sBlUUlv6mpML/mFC1gnuvftUu7GQKVQaQQAAXB+eemvlaA1SH/+xpDJzS3ILjBJlB+33Al7hE73VuaKFUYxb/EIY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710239394; c=relaxed/simple;
	bh=7BQBZQEZWzGbgfKljnIs0QsvUZnCKzK+sDNiXyr3xc0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kgCuQmZCowWEXBQN3+FXNJ8htKqTUSbfaIyaSZ8j3br1anm5STAy5q3vjyrz1jmL3JWCAmISu3JLinlzaHkzvOlSnL8BG2YXxOR2VrbTs25M4Urv2re5UdJT5kWPRaUzbPZ/Sefi4X6fdMul22gkv3r51urql4VuE+Isrvmr0no=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mbEqhKC5; arc=none smtp.client-ip=209.85.217.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f53.google.com with SMTP id ada2fe7eead31-47348b64b56so320465137.1;
        Tue, 12 Mar 2024 03:29:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710239392; x=1710844192; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=7BQBZQEZWzGbgfKljnIs0QsvUZnCKzK+sDNiXyr3xc0=;
        b=mbEqhKC5Q60uETDSIF0xFSW/GD2gOxDpjMC6CUa62/5sPAdaRLf+LqIKcoLXWY5pIo
         mXxjIjQ1c2QTcnrtgOPATRjfaeRtIzhe/VM/Ud6GePzKfu3wHQRs6qg5W+x7i7ZcAEpr
         w1YyVN5YDprCHdtthNM38fC7WRu4l0g+RhpXhoQhkJjrrRmrQuYIJkwHvYmlOsxxsAtH
         DjoQeMzCS1Sp/fvU4xiZJVtLG/Bf8Smzf45iQ03OI8N/Yq0Ujfzzc2dr8obS3ixKV8Ab
         TETgCjSqM7drdoTRbIZ9hkF7CbkuIqrsJyCEc0MT6+z6X0NQY8p5QTtighFXd4qw7oVI
         eVrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710239392; x=1710844192;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7BQBZQEZWzGbgfKljnIs0QsvUZnCKzK+sDNiXyr3xc0=;
        b=ntilV2G0Uyh6OtNDvj2IouemsCmhNhgmCj0IOmeBmtwU0lwO8962wRTKFII1nsRcNz
         oIXl/sHt52PChrx0a1HBejhP5IBLxPSVpBRf1cq1TBWogfLqyTdyrD2LgalhoDzq39NE
         z7Buc+Fv+eN3eFD0tV1s8KW19okEKiXYAuLcamYSp+cMgADCqdYg0t003C6sSWWAbZtm
         nQi7ss7EKbW9VAUMU3imCl55GzEvcjc6FPp4xQ+VgqbXWAkafnYNa6Tgd6UsuI831u9s
         yc4PitAukciodQB0JZsywVKwfJ5gZ6h2gTEu2VTXo474K4BAcjE9du1MwZUuM2Zb8kL7
         5mgg==
X-Forwarded-Encrypted: i=1; AJvYcCXsLcNG/Dou1J8VC+aPR0J1l7wl8P6Dptq7Iub9F9kdeWJzHsX5MWbYfRFzV7tgzPoLvpe1Xl9Hk639R2KuU/lyP8bipD0Tnfcdwh4TImcRkrlVonlzxfjMiP4Z3oSJmRdd7Lsq
X-Gm-Message-State: AOJu0YxIaLU00UJVcSJu3ov6GRnQ7XVENmtwwr+bo6Xcoh3RI2SMZmZc
	QyBz+CfuRMlba4MI7U3Gv9cZlP8afYqR760vpXzHBZoEpaF3rB040aN9eI01rKQZpNvep2MdJyE
	kOONpcE+hvEuWx6qguhN69ShJ4Aw=
X-Google-Smtp-Source: AGHT+IGkD0P7F8tx7lwSIyxICJzqzXGcCdhHe2449N4OpO89nUTsr1Ql+xRN06Bb7z+1VPWcuB0lRUbKcsBeXplOK0I=
X-Received: by 2002:a67:b347:0:b0:474:acae:f3c3 with SMTP id
 b7-20020a67b347000000b00474acaef3c3mr710675vsm.25.1710239392315; Tue, 12 Mar
 2024 03:29:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240312094259.770554-1-e.velu@criteo.com> <7169b33e1e4487370a530fb60d97dc096a24acfc.camel@redhat.com>
In-Reply-To: <7169b33e1e4487370a530fb60d97dc096a24acfc.camel@redhat.com>
From: Erwan Velu <erwanaliasr1@gmail.com>
Date: Tue, 12 Mar 2024 11:29:41 +0100
Message-ID: <CAL2JzuxA1h=L=0cr+Q6CZ9UDbHB6ptbzCQ7gZddZLi2JumdLQQ@mail.gmail.com>
Subject: Re: [PATCH v3] i40e: Prevent setting MTU if greater than MFS
To: Paolo Abeni <pabeni@redhat.com>
Cc: Erwan Velu <e.velu@criteo.com>, Jesse Brandeburg <jesse.brandeburg@intel.com>, 
	Tony Nguyen <anthony.l.nguyen@intel.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, intel-wired-lan@lists.osuosl.org, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

> On Tue, 2024-03-12 at 10:42 +0100, Erwan Velu wrote:
> > Commit 6871a7de705b6f6a4046f0d19da9bcd689c3bc8e from iPXE project is
>
> Please use the checkpatch-friendly commit reference: <12char hash>
> ("<title>")
Done.

> This looks like a legit fix that should target the 'net' tree, @Tony:
> do you agree?
> If so, Erwan, please include a suitable fixes tag in the next revision.
> Please include into the subj prefix a suitable target tree. I think
> this should go first via the intel tree for testing, so 'iwl-net'
> should fit.
Oh I didn't knew that part, thx. I'll wait @Tony to see what target I
should use.

> In any case please respect the 24h grace period when posting on netdev:
Yeah sorry for the v3 ... I shouldn't have done that way, that fast.

