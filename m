Return-Path: <linux-kernel+bounces-103616-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D91787C1F5
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 18:16:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 21973B21885
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 17:16:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1F66745F2;
	Thu, 14 Mar 2024 17:16:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="egBYLjzN"
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6268471B48
	for <linux-kernel@vger.kernel.org>; Thu, 14 Mar 2024 17:15:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710436561; cv=none; b=UZJ5FwXOYyEzd1YMjnIkRN9KaMoKWfcPWsJ+1f55rzA41wImbcWElpntem+J0strNcytFjjrDq4rBxGVZLsQ80hsOlVumEi3xpde+vZLUjCSUleUxAqKWk7Mchw9xNnykTN6sjXcOsrSEg6q/i4GUNl8Fy90fMJGtIRCdKsJQZw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710436561; c=relaxed/simple;
	bh=ASo+LDsMApRbUXPpMln5pwSC4HMvJj/Gm7MdWQsFt1s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HDx6myBrfmhf9t59xe+EBwLUM7dNnUC/tyfCx2ce2EPL1FBf8vzwuf7RWIIaBnGNC8KoeEL9vkDF0OqSfbwvFHPJLszm6dkndLFnpEsfwLU8uveiOKUiPj9fiFbG1CyLEtL9OY6Bv8UKk9pQ6VUkWCvBwtz1vvm7fUhKHzezLkw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=egBYLjzN; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-a3ddc13bbb3so416866666b.0
        for <linux-kernel@vger.kernel.org>; Thu, 14 Mar 2024 10:15:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1710436557; x=1711041357; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=95r3OCCclHMX2hfHWchTVWQ72JjnvU4/ijqwnCext1M=;
        b=egBYLjzNyavAZpzF1XcRfh/wH6l+W99Ub6q5Kg2yw+Xz/DcKV2cQ2CxyMqRTBp90OI
         av4A0Cqvvo8KLTXbOhR0M9BpfRUe0JyPRuche4MGPK7ag1IgvzozO5DGCWaYySItwKfp
         1qwQNvDUPUFhQqiM1QT2ebx+AB8z003K6OzgI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710436557; x=1711041357;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=95r3OCCclHMX2hfHWchTVWQ72JjnvU4/ijqwnCext1M=;
        b=uCTCenQ/SkzJGeCF1nVvVPGOHWla6tXgt6u7tWUOPiLCSRrCdJl4YIaXtwaDlWPiko
         ZVP91SyLprVla6m36sOsKuozXAn0RyGm0goX9RY/r90saHfq65NcJOn0h40+IArL+xsd
         EwsyK0x+Qu7ljcRyrGyE4GlADjluF5aut4rCsryw75U7ICTDcCIOPZjLor9sBh6cSxn9
         uYg1wIgQ0d+hEb+YqYc1NrqvbeZyhyY9J0WcccHzsgC7o80opefss0RMH0Ta40yopuXq
         NWDdpNEeCjP6s+TSlXwuumT4aIMP+BV7ny+T0T7Ca9gDmZ5r765RKnOPeBMRFx+LI4Up
         hutQ==
X-Forwarded-Encrypted: i=1; AJvYcCWhItwfmo12nG/4wZAGfxzbMGhRfBUS0Kv68Hb6kR9ZHC/fN9Y1yLzYozNRmDLUsSu7JupHLD9TIgF6ZVnO9sXzb/LRHiUxXyyQpQqs
X-Gm-Message-State: AOJu0YzDQ5m/1xVTjFELRzaSM+OIhLgCvH9yh6fGqbF0MF4M+eVDlIW8
	G2C8V9LrnpnMpdzF/eXJ3fitIso3af3bsfEZZmAy44kTzkH4wIiVWNJ34s4vGQhtNFgsOWckz7T
	Q8kJd+g==
X-Google-Smtp-Source: AGHT+IEfUhnGCsestabTPaNSm5KPFwjbov6qiAZLMP8gBYDrQGH4wBpREf3itT5YyEEfwO0E5VLm2Q==
X-Received: by 2002:a17:906:6ca:b0:a46:6884:ebc3 with SMTP id v10-20020a17090606ca00b00a466884ebc3mr3049039ejb.35.1710436557456;
        Thu, 14 Mar 2024 10:15:57 -0700 (PDT)
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com. [209.85.218.45])
        by smtp.gmail.com with ESMTPSA id bw9-20020a170906c1c900b00a4650ec48d0sm884247ejb.140.2024.03.14.10.15.56
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Mar 2024 10:15:57 -0700 (PDT)
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-a466a256726so218087666b.1
        for <linux-kernel@vger.kernel.org>; Thu, 14 Mar 2024 10:15:56 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCV5J7NMLcmarBUZXrg8BETYfLNxeTNLXJp2QcMI12LCLocoQ0hYHXBpYk+YWZCsJWCAq1hKCNFdTbtnWoWlSOsAPxlwV9Uly2+XAK81
X-Received: by 2002:a17:907:1b0e:b0:a46:4ea8:9df5 with SMTP id
 mp14-20020a1709071b0e00b00a464ea89df5mr6915486ejc.5.1710436556101; Thu, 14
 Mar 2024 10:15:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <lfypw4vqq3rkohlh2iwhub3igjopdy26lfforfcjws2dfizk7d@32yk5dnemi4u>
 <CAHk-=wg3djFJMeN3L_zx3P-6eN978Y1JTssxy81RhAbxB==L8Q@mail.gmail.com>
 <bqlnihgtaxv4gq2k6nah33hq7f3vk73x2sd6mlbdvxln2nbfu6@ypoukdqdqbtb>
 <CAHk-=whbgtooUErM9bOP2iWimndpkPLaPy1YZmbmHACU07h3Mw@mail.gmail.com>
 <hbncybkxmlxqukxvfcxcnlc53nrna3hawykbovq3h3u5xpm7iy@6ay4wjnpuqs4> <4q5fetc7qwunhhvieuiubk3g3guc4mr4a5wfmn5u4ox6kyo4p7@olyanpabfvav>
In-Reply-To: <4q5fetc7qwunhhvieuiubk3g3guc4mr4a5wfmn5u4ox6kyo4p7@olyanpabfvav>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Thu, 14 Mar 2024 10:15:39 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgaWNYqrH=DSMiKTtb0vO-9JZ8Vm7VQRT4=uprsaT0eMg@mail.gmail.com>
Message-ID: <CAHk-=wgaWNYqrH=DSMiKTtb0vO-9JZ8Vm7VQRT4=uprsaT0eMg@mail.gmail.com>
Subject: Re: [GIT PULL] bcachefs updates for 6.9
To: Kent Overstreet <kent.overstreet@linux.dev>
Cc: "Darrick J. Wong" <djwong@kernel.org>, linux-bcachefs@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Wed, 13 Mar 2024 at 15:28, Kent Overstreet <kent.overstreet@linux.dev> wrote:
>
> Sorry, you were talking about mean absolute deviation; that does work
> here.

Yes, I meant mean, not median.

But the confusion is my fault - I wrote MAD and then to "explain"
that, I put "median" in my own email - so you read it right the first
time, and it was just me being sloppy and confusing things.

They are both called MAD in their own contexts, and they are much too
easy to confuse.

My bad,

               Linus

