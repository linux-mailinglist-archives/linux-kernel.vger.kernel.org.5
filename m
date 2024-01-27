Return-Path: <linux-kernel+bounces-41408-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 540C783F05A
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jan 2024 22:59:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DD446283D27
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jan 2024 21:59:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D329C1BC51;
	Sat, 27 Jan 2024 21:59:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b="Wt/iIAWY"
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AF891B807
	for <linux-kernel@vger.kernel.org>; Sat, 27 Jan 2024 21:59:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706392773; cv=none; b=hm/HIf/51dNqpVYhtuoJ1jhKnW5u1u+KeIuifeiz2ySH2Xyi5dop0Q7psPKGtEcoN4+gL9T+hNvTOYDdcCaqs9iZnqRRxqM5NTWoSzlzV3o55L78fZkX2lCo54R9cAa/qn+vemHKsEneJKkoyH2UChMf7NE1S1ymqvlgJdl9uDY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706392773; c=relaxed/simple;
	bh=G/6KdXu31T1VAui/RJwqf6i/24VbdcZQazuZ9wjU2fQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Yg7/G1vRmLP/Z0eHiadIjfO4khwEeTXsMkKF+Krf3GHjvaV6+nh/sB27ufMB85S9S677VvrDHQl/h6yxvwbNK3RI1kmb7GY8PdfnTpY2CMKfWBTg3yHAgW4KqNZcp5Ct282C6Jg7zxi2+8rr8U+vb7aWSbxsKbzCHLod2jn1x/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b=Wt/iIAWY; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Received: from cwcc.thunk.org (pool-173-48-112-211.bstnma.fios.verizon.net [173.48.112.211])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 40RLwvVr024115
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 27 Jan 2024 16:58:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
	t=1706392741; bh=G/6KdXu31T1VAui/RJwqf6i/24VbdcZQazuZ9wjU2fQ=;
	h=Date:From:Subject:Message-ID:MIME-Version:Content-Type;
	b=Wt/iIAWYf1XC1gaI24a7MJaAJTcFxw1KSvcT6YWZ0T7RxjvDxYv4JXWL+ukbYPPDQ
	 lH9WT7iOCqHq90Sh08iByhVGVPc9kUTGjLr3qsQ6//mLLOuMI1J114gHjANv+/ah0/
	 wRBsDOOH05nnWw3HAOx5FvIBGfUt70ID2BVlUkbVljCdEPEwstuAmPz1kx/EFo1/fD
	 ljKJJw69gTjfm/WFXhIZmw2JWq3Yc4xzSI6dt5ftMPsgAn5cFPvE+Cu/9xrqxT3n5/
	 mEl2/Q5u99OKw695+WucacU7KjcejFMhQt4mHEXKAtRj6L5t6CXgjgjt5f/oljmbBa
	 lcZd4i4r98qEw==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
	id B138315C065B; Sat, 27 Jan 2024 16:58:57 -0500 (EST)
Date: Sat, 27 Jan 2024 16:58:57 -0500
From: "Theodore Ts'o" <tytso@mit.edu>
To: syzbot <syzbot+7ec4ebe875a7076ebb31@syzkaller.appspotmail.com>
Cc: adilger.kernel@dilger.ca, axboe@kernel.dk, brauner@kernel.org,
        jack@suse.cz, linux-ext4@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [ext4?] KASAN: use-after-free Read in ext4_find_extent
 (3)
Message-ID: <20240127215857.GC2125008@mit.edu>
References: <000000000000c7970f05ff1ecb4d@google.com>
 <00000000000064064a060fe9b55a@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <00000000000064064a060fe9b55a@google.com>

#syz fix: fs: Block writes to mounted block devices

