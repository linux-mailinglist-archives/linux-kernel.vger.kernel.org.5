Return-Path: <linux-kernel+bounces-76824-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C96F885FD26
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 16:55:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 066DDB278CD
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 15:55:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A72F15098B;
	Thu, 22 Feb 2024 15:54:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b="YokgSkvb"
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 217B814F9DC
	for <linux-kernel@vger.kernel.org>; Thu, 22 Feb 2024 15:54:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708617295; cv=none; b=BZGir1Uhzqfhcgloe7oYZBamxJPpB0hEyPBAFU8F3UiukL6pvY/7Ec+oyNFcdfCst8snUEcZT9WgOMqWz224GGLDYB/Vuoc2GL2OyDL3b3QKau+UUl64KWxLTXlsemBZkbgyUVYDKok2EpBJPzdhvwAEvl3OcjD0R14Kmk2rH30=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708617295; c=relaxed/simple;
	bh=j3ogpyh0GN0FFe2AaErEZEHmLcenYybX5HdtQJ3EA0M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DAwooFniE9M+wiUDA/JCw3gojKB+xVoeL3/7epQOLV8gOMGOnYJ1HkO4NUX7EAxu2Xq4N3lE3ntD8SjMa5dKhOiZNkHWIF0s33CrPNB8An4x6oAxUMVJ/U05XMjGZHMSw9fNwK7bp+dS5vZ3gZweyD6n8nAX5xghP8ZGNQ1ImZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b=YokgSkvb; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Received: from cwcc.thunk.org (pool-173-48-102-198.bstnma.fios.verizon.net [173.48.102.198])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 41MFsgLs030833
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 22 Feb 2024 10:54:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
	t=1708617284; bh=WRJ57KloqdhFQgn9Su2/MtOaFC3xCBvzRZgGq6/Sstk=;
	h=From:Subject:Date:Message-ID:MIME-Version:Content-Type;
	b=YokgSkvb6rKjKJBxc/NVxD2Dn/MRrCzt0r26Y0/SC7m+1NIvAMMapkaBzA+Zif9Fv
	 BSJvR4nTXdZCzlcncUNPINWzgAWzSaf/HbBxig7VWexp9Hffz1Uo/09TAZ0sJjlRET
	 cNuTjxOqiZKABsMn6q8O80HetdPZg80aUc67NVUcpG6OwjY0aOkqyGR7ygdCYQggHF
	 2dnWm84w+DbD7J3V2MCs8AcUIcuQOmH2yynU71knWDAyke2TAwB9174UjHZ29oC6Mx
	 wn7inw6aIV5dc1a0tqE74cgsSYbHqLd4Q20XLgkH+IneBXs0rIKdmwIKf7OAUDcbeu
	 4qSQKby/F1DFQ==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
	id 3CC6D15C145A; Thu, 22 Feb 2024 10:54:40 -0500 (EST)
From: "Theodore Ts'o" <tytso@mit.edu>
To: adilger.kernel@dilger.ca, Cheng Nie <niecheng1@uniontech.com>
Cc: "Theodore Ts'o" <tytso@mit.edu>, linux-ext4@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ext4: fix the comment of ext4_map_blocks()/ext4_ext_map_blocks()
Date: Thu, 22 Feb 2024 10:54:33 -0500
Message-ID: <170861726751.823885.13414859909628867406.b4-ty@mit.edu>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240118062511.28276-1-niecheng1@uniontech.com>
References: <20240118062511.28276-1-niecheng1@uniontech.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Thu, 18 Jan 2024 14:25:11 +0800, Cheng Nie wrote:
> this comment of ext4_map_blocks()/ext4_ext_map_blocks() need
> update after commit c21770573319("ext4: Define a new set of
> flags for ext4_get_blocks()").
> 
> 

Applied, thanks!

[1/1] ext4: fix the comment of ext4_map_blocks()/ext4_ext_map_blocks()
      commit: 547e64bda9c7bd6bda2d20a329bb0f60258fe19b

Best regards,
-- 
Theodore Ts'o <tytso@mit.edu>

