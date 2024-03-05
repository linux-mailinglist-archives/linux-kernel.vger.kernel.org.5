Return-Path: <linux-kernel+bounces-92046-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D40A1871A32
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 11:07:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 53225282DE6
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 10:07:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49C7C5475D;
	Tue,  5 Mar 2024 10:07:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KfN54v7w"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 236D9535CF
	for <linux-kernel@vger.kernel.org>; Tue,  5 Mar 2024 10:07:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709633241; cv=none; b=rW0U6EtX/mCc2OiE+arYOY6QbQbcV0bc0mY6KLvMkT58YLP6XmM2szHIm1/0MU6XpDzeHOQokF+SZRt1wdoj4ugyXjBsmfzjq5RhIAkWLczLA9WcLgIBd/GhgHWZ7UXcSwP2fDzeGNF7G+K6zChh9T03nl+jnW76qO41XL5UQSw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709633241; c=relaxed/simple;
	bh=tmWvhUXEZZ3pBn0rRhtM8Nj4vDkTWD01IJZIJla18XM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EDIR5W1ko2gqlilc2GuGFMueuTqCMK9FZwPrpMGOM/5xSzSQysd/jZOLcXUB6ZUBGSrJpn5RZ3yXB3CkuwM9vNUIkEXXZytK5Lw/sib3GKJ66x5xmmsZNEy6YDQ4lN6NkR4Xadc9th/ShWxaofCKpFjvvPrr6rDOsk3l3/PmyJY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KfN54v7w; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1709633239;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5LvzkgpPOzZwlEgXOsRWtL0iyRGHSE/p12vv2dYEEWM=;
	b=KfN54v7wKpZnBko2P5nLaVhRMkBze0S2EDlpKoHSavaCxQa0aEJ1z1OhRGdtZbXR+X1MI9
	O8gZ7w5gD9lRojAcwsLzG0t/dBhf1Ut6572Ah6ZKUdzck3e5+wjcHoZQFRp34xofWwlqNJ
	KZq1JYKohfMe0RLdWqk+IoDAxYWszjA=
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-460-IIg8kVZ-M4GmFzXHm1BUww-1; Tue, 05 Mar 2024 05:07:17 -0500
X-MC-Unique: IIg8kVZ-M4GmFzXHm1BUww-1
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-1dbcbffd853so55944345ad.3
        for <linux-kernel@vger.kernel.org>; Tue, 05 Mar 2024 02:07:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709633237; x=1710238037;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5LvzkgpPOzZwlEgXOsRWtL0iyRGHSE/p12vv2dYEEWM=;
        b=ofKUWGLOTDYTJgaBLItu/+7mF4sF7FPxP/vAwT7FI4B8gItxJFe8nscOD8Cf9Wufe7
         +qlxTw7C85OKT8rfJDKdq61ets8pTessiJnUERwNJ0t4o/j3d41tSolYDs+kY4pEBpEb
         fmbhusZizn9yY6gIYfBlAwe/xl0ATjNd/m5wOqPVYqM/lNeZB+Tk0OtyI6Anl8LMcKhX
         tK79PEHFEMYH3CCEUqaV1VOKFDTjtCzKj4n7LY5gRwUeca9bPMDKpOxGqpztkSjII2YV
         arYtpoJ1JaMtx7j3RssWGbKx+BrVNSVq3UuPmNMYah5XHFWL3ZbzFzQbuhTH1CvXYO11
         SaQQ==
X-Forwarded-Encrypted: i=1; AJvYcCV+ZeTtqOJbvyt70H+/1uzEVruh37gWw1c5oKVocq4RZFOi4eYnS2+RO4pyfY/ThOCfzhX6gZYNCANDNNEciHo5H+eme3NBsB4KvxQx
X-Gm-Message-State: AOJu0YzaS0KY69Ctfi4FNy/E+OBw24PfzB2UqTxZekv1F2aM02U7PCDx
	wjXq1dKFm8d+QvzfSxSfnnLVIXHq65zeTme7k9NTsGN/YNXHxOR8YGOw4+NUZb3XcrA1YJbI6HC
	Kwp6RSqZUDrsnIG/UMabFRIrqgEPOVTI6dWE1laY3OXwETOpU+se95yNHIJam4xsNTakkr7K9vn
	UUYLdv29kw7wBbEFh1C3r/ej6HPg4BQPdBAqZy
X-Received: by 2002:a17:902:ce8d:b0:1dc:b320:60d2 with SMTP id f13-20020a170902ce8d00b001dcb32060d2mr1446797plg.33.1709633236849;
        Tue, 05 Mar 2024 02:07:16 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHMv6QAUQFA2PQMt09dU18T+73TTHk4Z3gqozQBVsQrgdPPOTCB2inQqNxcby7aXzwG2tWIwk4xFqDbjP3soXg=
X-Received: by 2002:a17:902:ce8d:b0:1dc:b320:60d2 with SMTP id
 f13-20020a170902ce8d00b001dcb32060d2mr1446786plg.33.1709633236559; Tue, 05
 Mar 2024 02:07:16 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <000000000000c925dc0604f9e2ef@google.com> <0000000000000c6e0a0612e6bd58@google.com>
In-Reply-To: <0000000000000c6e0a0612e6bd58@google.com>
From: Andreas Gruenbacher <agruenba@redhat.com>
Date: Tue, 5 Mar 2024 11:07:05 +0100
Message-ID: <CAHc6FU5ynRASxSQDYPMZ7FHuOmjxPbqe0E+TTJEc19+ArJby0Q@mail.gmail.com>
Subject: Re: [syzbot] [gfs2?] BUG: sleeping function called from invalid
 context in gfs2_withdraw
To: syzbot <syzbot+577d06779fa95206ba66@syzkaller.appspotmail.com>
Cc: axboe@kernel.dk, brauner@kernel.org, gfs2@lists.linux.dev, jack@suse.cz, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	rpeterso@redhat.com, syzkaller-bugs@googlegroups.com, 
	yuran.pereira@hotmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 5, 2024 at 10:48=E2=80=AFAM syzbot
<syzbot+577d06779fa95206ba66@syzkaller.appspotmail.com> wrote:
> syzbot suspects this issue was fixed by commit:
>
> commit 6f861765464f43a71462d52026fbddfc858239a5
> Author: Jan Kara <jack@suse.cz>
> Date:   Wed Nov 1 17:43:10 2023 +0000
>
>     fs: Block writes to mounted block devices
>
> bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=3D119f927a18=
0000
> start commit:   6465e260f487 Linux 6.6-rc3
> git tree:       upstream
> kernel config:  https://syzkaller.appspot.com/x/.config?x=3D8d7d7928f7893=
6aa
> dashboard link: https://syzkaller.appspot.com/bug?extid=3D577d06779fa9520=
6ba66
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=3D10dbcdc1680=
000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=3D17a367b668000=
0
>
> If the result looks correct, please mark the issue as fixed by replying w=
ith:
>
> #syz fix: fs: Block writes to mounted block devices

Sounds reasonable:

#syz fix: fs: Block writes to mounted block devices

Andreas


