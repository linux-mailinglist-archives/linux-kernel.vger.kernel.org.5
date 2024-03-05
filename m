Return-Path: <linux-kernel+bounces-91627-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C5F9871463
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 04:42:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E20391F225AB
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 03:42:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 430053B193;
	Tue,  5 Mar 2024 03:42:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GAVjS41u"
Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B4F41E4A2;
	Tue,  5 Mar 2024 03:42:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709610161; cv=none; b=R6iZTMIWEcSD6AbVfdRfXdCuMuoh0JCpLP5ur26xfJLPfAdxekeoo0NoCmeEXQEK9yqcB5+OXR0Mewf7peEosQiKnW255l3gUdJ6QnjHaLQfB66bNi3Gf9VNywvL25rCMEvJZ7fTba29F3ZXtB9neHrJ8hGR1e8kq5S8VnAfNeY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709610161; c=relaxed/simple;
	bh=RwRBAEByzfgNvSIoEkSYsQAPUWr2a9oJKDmQl400sLA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JLNu0d3cxvl5twM1OOB40FvFs1MAkzS/wPs1RZvUKOMUtQ1OFuHpLlVQ8XUQFPMGRDuMVwOBda55J4rxB5Y6icnVyxgsyuFg3wgA5uCfpKtXm0wRhE20J/7NA3H7CqSqGG2yKtK4JRiMwo53EYAtxPwb+hTMRoZ0wnVZDWRA8aA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GAVjS41u; arc=none smtp.client-ip=209.85.128.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-607e54b6cf5so35648937b3.0;
        Mon, 04 Mar 2024 19:42:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709610159; x=1710214959; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=RwRBAEByzfgNvSIoEkSYsQAPUWr2a9oJKDmQl400sLA=;
        b=GAVjS41uVQFWRIpgJ15jH2BflUHxBxZ786xnEi7TjhUOjnAt4esI33YPRF8GjUnmx3
         fR5KyM5d4gIxctnzVec1FgSR3j3UqTJ6oh/gOCLE1b3rX5XB07+EATNyfBQq/Rta29fZ
         OsDgULl8GRg8NpedO+36VCuxXb5l+pJL+G00enzdS9Yhmhn3oDzjMv7mD6mkYeAumnqW
         Rm8A4uDdRn56Qj6nxSuboD457H400irOcytDqdolB0BjSr3UkypLHIkSeI64tqj08DaR
         gjcYgczBozABHbGKwLBc9H1mp13hV5VocF/9N/PoDSb9W/dwQmqtuwgOFaC5Xc0JY46t
         lp4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709610159; x=1710214959;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RwRBAEByzfgNvSIoEkSYsQAPUWr2a9oJKDmQl400sLA=;
        b=VIRw5QtBWHxlApFyXxyWEHBG/NMhcqgnnosKoloz1dCYVO9b5JQck+mvkVMCN83113
         z40juaDQy0B3f+j3dfKXT5Ka+puzQktRLdl6aFQLhkf4ZcE3q3Qi48K+J3Var2tPrUS3
         moVBi3Ke4ONvE0X2e/xjSZkYkiv7sjgEiwZvOzmWuSmLtJRBMb+zctbjUrSMAVyRdm6n
         zzTSvopa4XVq93zY04DC5uu3W4jwr6tDOu8NQ++m2iwGYqCQSUhkMYyhXI5eS4C7osni
         oENn1/EckUdWWP8v2vNMKShwMZxZaxprlyPNZNYOMz8NhN+tMGTXbM1g8grCVwCt1LNN
         TH3w==
X-Forwarded-Encrypted: i=1; AJvYcCVQshNjLEVl5HxOcH4FaCKeIzFwuBMOVg32fPMD/GuiYO2oKC/GjZEWU6Iy895RY1uRE09mH4S6S7VHNytiQLVc5cJFQdSH3obPq/GCZT2yyq74cacfaUFunThKpPJzsY36chfvOeyN5+5bHnxMNG/A/3XvFA2m9w5Zh+Rjhwft
X-Gm-Message-State: AOJu0YwhMbjxZpCl+BXTt0FhAkGjU+Uak9Ztz6C9NW6xttz9j7J65oFG
	A2HK18vs7rRXQucdVEXuirdaM9ewKWLB/6frdAzr0mPLy2KTfi/4W9cmQBoqCSFe5KQHVVbOYTp
	7BQeK8guMzO/rcXE8M0N28G3FZXc=
X-Google-Smtp-Source: AGHT+IER45kqclRcXl4fWTfOH2b6RQ9iRuXolGj6iEgJsDljotli7ZMu3Qshsdrtu/apb/P821DTmoI1JanZrWwNpE8=
X-Received: by 2002:a0d:f407:0:b0:609:8cec:36a4 with SMTP id
 d7-20020a0df407000000b006098cec36a4mr966597ywf.19.1709610159049; Mon, 04 Mar
 2024 19:42:39 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240212020403.1639030-1-hayatake396@gmail.com> <CYYPR11MB8429FCD568EE2AF90AEE2CABBD5E2@CYYPR11MB8429.namprd11.prod.outlook.com>
In-Reply-To: <CYYPR11MB8429FCD568EE2AF90AEE2CABBD5E2@CYYPR11MB8429.namprd11.prod.outlook.com>
From: Takeru Hayasaka <hayatake396@gmail.com>
Date: Tue, 5 Mar 2024 12:42:28 +0900
Message-ID: <CADFiAc++edOb7-O6yCUgpAaonZ1sQdkrwwH8432D=e40g1CwoQ@mail.gmail.com>
Subject: Re: [Intel-wired-lan] [PATCH net-next v8 1/2] ethtool: Add GTP RSS
 hash options to ethtool.h
To: "Pucha, HimasekharX Reddy" <himasekharx.reddy.pucha@intel.com>
Cc: "Brandeburg, Jesse" <jesse.brandeburg@intel.com>, 
	"Nguyen, Anthony L" <anthony.l.nguyen@intel.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Jonathan Corbet <corbet@lwn.net>, "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>, 
	"vladimir.oltean@nxp.com" <vladimir.oltean@nxp.com>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"laforge@gnumonks.org" <laforge@gnumonks.org>, Marcin Szycik <marcin.szycik@linux.intel.com>, 
	"intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>, 
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>, 
	"mailhol.vincent@wanadoo.fr" <mailhol.vincent@wanadoo.fr>
Content-Type: text/plain; charset="UTF-8"

Hi Himasekhar Reddy-san

> Functionality wise its working fine. But the ethtool part (tab complete doesn't show GTP)

I forgot to add the tab completion feature! Thank you for the good
points. I've added it again in this version's patch.
https://lore.kernel.org/all/20240305033555.524741-1-hayatake396@gmail.com/

Takeru

