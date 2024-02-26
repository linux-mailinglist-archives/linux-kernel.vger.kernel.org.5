Return-Path: <linux-kernel+bounces-80736-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E02BB866BE0
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 09:15:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1E12F1C214CE
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 08:15:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A8671CAAE;
	Mon, 26 Feb 2024 08:15:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="Iv1w8886"
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFBD11C6A7
	for <linux-kernel@vger.kernel.org>; Mon, 26 Feb 2024 08:15:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708935307; cv=none; b=rP4oi2vQwfFNTg+BxM3GkqaoSB04aPO7jvVwTCmTgwn3xANApom12fqhZ3WaAs3hSMM+AAyOjWKSgvlbTU6xSkyRfCr7d0mrKDzN6wru5GI1q4GEkcIpxsiXgRlGNAwNkZ7rg4N0fDJceY+T/qRNHGjHvRfZUU3KP/6sRmaApRU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708935307; c=relaxed/simple;
	bh=wc6imTjryGlZEGM8Hd8Jr4/OgAt8z10WVDMkwzjaplg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nl5JUWcwloCs+WHkfyMmyxBH5IDk00W7MLXqRs5oxo7Nfc43akaPztO+YMIoggy3zzauNRWigkll+jk2GmWChfImUasQMRKeOBGf/gB/tT17AeqDcHeuH2BXnR6ODGuuJ65PAku+vmuMkvOeFET1iQkZ9OQkzb9mlyQXetLPsz8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=Iv1w8886; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-a3e72ec566aso336226166b.2
        for <linux-kernel@vger.kernel.org>; Mon, 26 Feb 2024 00:15:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1708935303; x=1709540103; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=tXChnYM6jqoevNoB06P78tnxuorT/1Io0Mk4HtClhXM=;
        b=Iv1w8886SfgA19CpcF2knQdSFAMl+enITl8gv1lm9dBe3PwBmUuUPD2vm0BEu+YFfe
         eF9Wn7aQ+52lonyWUn1a0crWNWzTYP8bahasZi+RGlu6/0nyK3b5qWuTEmocvB6FeHMh
         To0jQbVy9polW3MgJemaT4cG4ovUH2+8XuMAQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708935303; x=1709540103;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tXChnYM6jqoevNoB06P78tnxuorT/1Io0Mk4HtClhXM=;
        b=VTXDJAtElcC/Ygaxe9/WNBH0r3J3rwh/DngY0nS6CpCKt6JHTXPDYbES2IiMQ0NuR9
         gxKCeyyw/NgWh0ItYmIcLvp0oSv3Fxn9BU6EAO1Rpktuxp0A8vbz18gDvVhne5XGH0Dh
         jrFk6hTsSwHpURKGJKMTCAX2Dc5OLe5yPJFqu+Jm3fr/nyxPrItT481L5pRQiVDtbaSJ
         PN3CYkRQkph88T5vmzKHkNAKm5kEvWOICFRmZRykyS3UOuul5HnrKN76EoE3Ch8+NRZV
         69BIhQTbRDht12gzjMX0PwWv+GERjFLNBFfCETvdq4upIfKQ6AY7NNibiWNMDl261lBr
         gelA==
X-Forwarded-Encrypted: i=1; AJvYcCUoBEsZ2IgIk6TcLQnTT4q1bPYmHrsw+N40ZLTjTroL0V8MhaWaWDTDh0g2lm3JqTdDCpZzbUQn210Zpw18pynH3kAh7Ah3lKRMbBe0
X-Gm-Message-State: AOJu0YxPI49JqqqtNjC0PBxZz+lWRsmxm5XLacRm50ZXshziLC374rTU
	gNS31qA6YIA8b8PUjOFhefOxuvNCkfO/oAPN56pW78apSWvjHPyBS/sRtoUS10a70mvKBESPElO
	m5O7XRp5pqaHQf3kq80y0XWDm1IwcHt58T4D09w==
X-Google-Smtp-Source: AGHT+IH2bEcWWKZhtSpcqVfNN3HRnSrKljnvZLVLF3StAQMjpLEdFDMGIoyyE/VYuQFRBAyUtqaGPeKO+HUcp1F2vGo=
X-Received: by 2002:a17:906:3657:b0:a3e:127b:690e with SMTP id
 r23-20020a170906365700b00a3e127b690emr3685184ejb.70.1708935303115; Mon, 26
 Feb 2024 00:15:03 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <2uvhm6gweyl7iyyp2xpfryvcu2g3padagaeqcbiavjyiis6prl@yjm725bizncq>
 <CAJfpeguBzbhdcknLG4CjFr12_PdGo460FSRONzsYBKmT9uaSMA@mail.gmail.com>
 <20240221210811.GA1161565@perftesting> <CAJfpegucM5R_pi_EeDkg9yPNTj_esWYrFd6vG178_asram0=Ew@mail.gmail.com>
 <20240222154802.GA1219527@perftesting>
In-Reply-To: <20240222154802.GA1219527@perftesting>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Mon, 26 Feb 2024 09:14:51 +0100
Message-ID: <CAJfpeguEbd1h96OVhDAPEwoWGrF0Nk7q0GD9W6FhGp+eVgVRCQ@mail.gmail.com>
Subject: Re: [LSF TOPIC] statx extensions for subvol/snapshot filesystems & more
To: Josef Bacik <josef@toxicpanda.com>
Cc: Kent Overstreet <kent.overstreet@linux.dev>, linux-bcachefs@vger.kernel.org, 
	linux-btrfs@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	Jan Kara <jack@suse.cz>, linux-kernel@vger.kernel.org, 
	lsf-pc@lists.linux-foundation.org
Content-Type: text/plain; charset="UTF-8"

On Thu, 22 Feb 2024 at 16:48, Josef Bacik <josef@toxicpanda.com> wrote:

> Right, nobody is arguing that.  Our plan is to
>
> 1) Introduce some sort of statx mechanism to expose this information.
> 2) Introduce an incompat fs feature flag to give unique inode numbers for people
>    that want them, and there stop doing the st_dev thing we currently do.

I don't get it.   What does the filesystem (the actual bits on disk)
have anything to do with how st_dev is exposed to userspace
applications?

This is not a filesystem feature, this is an interface feature.  And I
even doubt that salvaging st_dev is worth it.  Userspace should just
be converted to use something else.  In other words st_ino *and*
st_dev are legacy and we need to find superior alternatives.

Seems like there's an agreement about file handle being able to replace st_ino.

I'm not quite sure fsid or uuid can replace st_dev, but that's up for
discussion.

Thanks,
Miklos

