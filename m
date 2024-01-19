Return-Path: <linux-kernel+bounces-31136-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 10F7A832990
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 13:34:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8C5F3B21365
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 12:34:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3F4B4EB5B;
	Fri, 19 Jan 2024 12:34:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M1MXdwFT"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 373C731A61
	for <linux-kernel@vger.kernel.org>; Fri, 19 Jan 2024 12:34:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705667644; cv=none; b=l6Zo1yC+cuMzdMp1leJENIemv8BL9GSmzZVCf8ScZNqqW2BsiI4Ba9yw+2WlY/RmNYwG0m+Wbk0TA7u6f0/2zoFgCls2OsoDqfwMP7e8ZRYbES/wSQqfHhPfMbWcWzmmjX6/s0/h13j0ljoyPiBx6Xk8VDqqbDVhfvHjHIIUgOE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705667644; c=relaxed/simple;
	bh=6k/8ixRqRz3mjyrw03nskAuYCsAIBXEIWRS9B4IVC8s=;
	h=MIME-Version:In-Reply-To:References:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=o8hHWrjIzI7i4adas2nOhiUkP1E/HtwfpwhP0UZ6P2UsuNKyy8jtPXbDntMkdcguKXt+lKD7r+xoVstdwzjbMlx4V8TLzfc+ai6BfWJtUsQrlqqRmRLao/Dh/2JyGMyWT7Kmu0FkVlpR9LjPD03iFbh3nVsNVa6vZSX4+yf2QDE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M1MXdwFT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB6E9C43390
	for <linux-kernel@vger.kernel.org>; Fri, 19 Jan 2024 12:34:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705667643;
	bh=6k/8ixRqRz3mjyrw03nskAuYCsAIBXEIWRS9B4IVC8s=;
	h=In-Reply-To:References:From:Date:Subject:To:Cc:From;
	b=M1MXdwFTSBP8EKmVSnVFa1QbRAP8GasZ/x+PpB7sAV0Sg0kFLJ7/lch60C6Q+bWRG
	 +KAzp1CxFKamIbFvZeUHOdRdB6f2SzVnTDva1JmeIh/EqQHMAW9J432uUdYKjIaTIo
	 Zz1SpazLPSQlKa05PMWkQ2llF5FgZ/6SyXmb9wiX7POu4Bd7gqRWnsSZZgxqBS/DND
	 Ng1xypcDlEZJgpDa2wRaMvuPHooNJr9vShD8dJQQriVN3focT6PzTgCn/qVTAwZrEc
	 OuenVRqmh5xW6y1MFzgnPPFiIUH5XBihEexFjQcpqIfYv+0+31OmTA4DBEJWLX0jX5
	 4XsYoL8r1EPoA==
Received: by mail-oo1-f45.google.com with SMTP id 006d021491bc7-5989d8decbfso396556eaf.2
        for <linux-kernel@vger.kernel.org>; Fri, 19 Jan 2024 04:34:03 -0800 (PST)
X-Gm-Message-State: AOJu0YwHkfHAHlB3XPfjvoZSn9JLwnbbhREZpKxoGiKwNVdwDlum3EZm
	zfVbyO64SvLODkgo55aAtAo0RLTwHV3O1aT7kQRleBeNg4+0ynNSPIJmi0WewhIKlsPj2cvgJ58
	p8p/RpLA/WUnIiVCve067jBDrdWk=
X-Google-Smtp-Source: AGHT+IHugEjAkL860HsP3ly2qhA6oeRA7GgKTVOhP4FpZ33tkWNyYhg1mGGjsGgG88bTqCp3AxePdsCdaEUPtCeUrYM=
X-Received: by 2002:a05:6820:824:b0:596:3aaf:3eca with SMTP id
 bg36-20020a056820082400b005963aaf3ecamr2488567oob.18.1705667643106; Fri, 19
 Jan 2024 04:34:03 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Received: by 2002:ac9:6c8d:0:b0:513:8ad5:8346 with HTTP; Fri, 19 Jan 2024
 04:34:02 -0800 (PST)
In-Reply-To: <000000000000141046060f4a7031@google.com>
References: <tencent_1B2ECE8078726E5C2D856C0497A0E80EED0A@qq.com> <000000000000141046060f4a7031@google.com>
From: Namjae Jeon <linkinjeon@kernel.org>
Date: Fri, 19 Jan 2024 21:34:02 +0900
X-Gmail-Original-Message-ID: <CAKYAXd_hjQ_FVx5t_cpNPCxgnOLzVy02h=bsPEepD4NyJ61MKQ@mail.gmail.com>
Message-ID: <CAKYAXd_hjQ_FVx5t_cpNPCxgnOLzVy02h=bsPEepD4NyJ61MKQ@mail.gmail.com>
Subject: Re: [syzbot] [exfat?] kernel BUG in iov_iter_revert
To: syzbot <syzbot+fd404f6b03a58e8bc403@syzkaller.appspotmail.com>, eadavis@qq.com
Cc: linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

2024-01-19 20:04 GMT+09:00, syzbot
<syzbot+fd404f6b03a58e8bc403@syzkaller.appspotmail.com>:
> Hello,
>
> syzbot tried to test the proposed patch but the build/boot failed:
We already have a patch to fix this.

https://git.kernel.org/pub/scm/linux/kernel/git/linkinjeon/exfat.git/commit/?h=dev

Thanks.

>
> failed to checkout kernel repo
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git on commit
> 052d534373b7: failed to run ["git" "fetch" "--force" "--tags"
> "4d52a57a3858a6eee0d0b25cc3a0c9533f747d8f" "052d534373b7"]: exit status 128
> fatal: couldn't find remote ref 052d534373b7
>
>
>
> Tested on:
>
> commit:         [unknown
> git tree:
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
> 052d534373b7
> kernel config:  https://syzkaller.appspot.com/x/.config?x=7c8840a4a09eab8
> dashboard link:
> https://syzkaller.appspot.com/bug?extid=fd404f6b03a58e8bc403
> compiler:
> patch:          https://syzkaller.appspot.com/x/patch.diff?x=147423afe80000
>
>
>

