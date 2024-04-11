Return-Path: <linux-kernel+bounces-141303-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 073A78A1C4E
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 19:44:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9B9501F283DF
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 17:44:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A2A832C8B;
	Thu, 11 Apr 2024 16:15:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="PvpttXMq"
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6A2E15E7E4
	for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 16:15:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712852132; cv=none; b=n/Ae6bR8X+lJp2iH455l3hPTulN2n5YwFbGl53zkRmcs8WEqqPDOu3VrCY+7HuVoO3SAcusAJv8nZigfITzwuOC3wLwz7duQzsI00rzb9BPU2DRn2T2OQmShfxQXscrTuXzECSeYQT9ESdbDPz+GbAbUm+fgOa/ZPIlsAfNbSLU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712852132; c=relaxed/simple;
	bh=LkGZWrwcM7i1Yw0nWiLzlJnspf96t1s3gPexteQnoII=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dc4P1rfTZEWsW0Dvqnpafw+TSrS9MIvJzOjpUlqUxncMhZ4tVRVTYa2Fx2d5pyEWW+op3cGCb666wByOcQzer5d2TRo4uXj4ozod5HpbXJQv2/SPUKuE6qX7rHl5tvXWTkw9TxDq6X0DNObXyBIszLXMXxx/peb0IdL1718yHUE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=PvpttXMq; arc=none smtp.client-ip=209.85.208.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-2d700beb60bso129171281fa.1
        for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 09:15:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1712852128; x=1713456928; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=YBU5cbcti1MoT6SGDsy6z4cIdlnVeSMn7eSvY9b74qk=;
        b=PvpttXMqhyOCJz+iu0AnVRjMW1DGLYX//13HX/uoNuQS5Db9uMZb1etPQTpC97Qkfd
         OMFLYm/B6gbFTDPxdehxgqQ6R32+C5EgoP8xFzFpfttpk88wpS62L1ORULHm/FMK6Dzw
         eLVf96rxuGN7ygULbg8NqgjCoStq0DLnNfMlQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712852128; x=1713456928;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YBU5cbcti1MoT6SGDsy6z4cIdlnVeSMn7eSvY9b74qk=;
        b=PYVKXTTb0AG0JpAVxQCB7wELexWeoQAKFg6MVyo3tAs5Mtt5q9iG/48LwyLWO6yhUD
         t+4LXiHA4dKVBpvJeViGXaIC40MeK8W/eITu09o6MKq9xSggqhu9H+etgghICikBLqUp
         xFCNB7PLYNHfwz5+lsgnu1vdSCNDXIhz9uyTfQX+/uHLQs+LrsjWRzEKutcraam9uzWp
         6AennJVe1rh8Yoi35Na3hdNL2MDiTtaa5zxujf5bDM1F07kDCCLgP8HEfV5bcMyFp8g+
         rX8/vZLBG6xMMHQKb9gH+KN3Oq/Y6Gmil/YVU2Zc6iiUmhHF7VVS/qKA3OUsxY0TbLmQ
         mjog==
X-Forwarded-Encrypted: i=1; AJvYcCWGmcR0otOyy3Js4sa1GcW6SY2NkqMgLque7g3d0jJFS82t/h0pKRE/x3WIF0Vb+fsygdDsAZ6rRj64D+GK2XQd8GPVouwDJB7suemd
X-Gm-Message-State: AOJu0Yx0cW2p2CHo9Q2REcOlvqSSJSB4ufoKuV65pppEkYx+/Fwoj9ci
	RIP+a/seTMKB68ESanJDhIjCWSRAwk8h0HfElmVlDP+GLWgFUOYEv1CNH373qUmn1j+vaVIkTNJ
	GFcUGyQ==
X-Google-Smtp-Source: AGHT+IH1elo3uGEHQxgNB1kpOsGQXpUlTcHoFlDE9L57JbSYcSVx3POREy4tu5uBrMfaABtbwqYusA==
X-Received: by 2002:a2e:890c:0:b0:2d6:e148:2463 with SMTP id d12-20020a2e890c000000b002d6e1482463mr82555lji.24.1712852128575;
        Thu, 11 Apr 2024 09:15:28 -0700 (PDT)
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com. [209.85.208.176])
        by smtp.gmail.com with ESMTPSA id e14-20020a2e930e000000b002d6b801a863sm252500ljh.34.2024.04.11.09.15.27
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 11 Apr 2024 09:15:27 -0700 (PDT)
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-2d82713f473so137875891fa.3
        for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 09:15:27 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWzFtTvovjtovOE1e5re/GlvOWHQoNksHuZ+AY7NFssEv/kpEtj/DNG6xLYLX5fUHgNcygTgrfiZKvW9OuW1ov59n5cHqRWfpV13tyw
X-Received: by 2002:a2e:b90a:0:b0:2d4:6a34:97bf with SMTP id
 b10-20020a2eb90a000000b002d46a3497bfmr57110ljb.49.1712852127138; Thu, 11 Apr
 2024 09:15:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240411001012.12513-1-torvalds@linux-foundation.org>
 <CAHk-=wiaoij30cnx=jfvg=Br3YTxhQjp4VWRc6=xYE2=+EVRPg@mail.gmail.com> <20240411-alben-kocht-219170e9dc99@brauner>
In-Reply-To: <20240411-alben-kocht-219170e9dc99@brauner>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Thu, 11 Apr 2024 09:15:10 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjrPDx=f5OSnQVbbJ4id6SZk-exB1VW9Uz3R7rKFvTQeQ@mail.gmail.com>
Message-ID: <CAHk-=wjrPDx=f5OSnQVbbJ4id6SZk-exB1VW9Uz3R7rKFvTQeQ@mail.gmail.com>
Subject: Re: [PATCH] vfs: relax linkat() AT_EMPTY_PATH - aka flink() - requirements
To: Christian Brauner <brauner@kernel.org>, Charles Mirabile <cmirabil@redhat.com>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Andrew Lutomirski <luto@kernel.org>, Peter Anvin <hpa@zytor.com>
Content-Type: text/plain; charset="UTF-8"

On Thu, 11 Apr 2024 at 02:05, Christian Brauner <brauner@kernel.org> wrote:
>
> I had a similar discussion a while back someone requested that we relax
> permissions so linkat can be used in containers.

Hmm.

Ok, that's different - it just wants root to be able to do it, but
"root" being just in the container itself.

I don't think that's all that useful - I think one of the issues with
linkat(AT_EMPTY_PATH) is exactly that "it's only useful for root",
which means that it's effectively useless. Inside a container or out.

Because very few loads run as root-only (and fewer still run with any
capability bits that aren't just "root or nothing").

Before I did all this, I did a Debian code search for linkat with
AT_EMPTY_PATH, and it's almost non-existent. And I think it's exactly
because of this "when it's only useful for root, it's hardly useful at
all" issue.

(Of course, my Debian code search may have been broken).

So I suspect your special case is actually largely useless, and what
the container user actually wanted was what my patch does, but they
didn't think that was possible, so they asked to just extend the
"root" notion.

I've added Charles to the Cc.

But yes, with my patch, it would now be trivial to make that

        capable(CAP_DAC_READ_SEARCH)

test also be

        ns_capable(f.file->f_cred->user_ns, CAP_DAC_READ_SEARCH)

instead. I suspect not very many would care any more, but it does seem
conceptually sensible.

As to your patch - I don't like your nd->root  games in that patch at
all. That looks odd.

Yes, it makes lookup ignore the dfd (so you avoid the TOCTOU issue),
but it also makes lookup ignore "/". Which happens to be ok with an
empty path, but still...

So it feels to me like that patch of yours mis-uses something that is
just meant for vfs_path_lookup().

It may happen to work, but it smells really odd to me.

             Linus

