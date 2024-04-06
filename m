Return-Path: <linux-kernel+bounces-133735-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CBD689A7E0
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Apr 2024 02:10:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 18C802825D0
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Apr 2024 00:10:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96B683D7A;
	Sat,  6 Apr 2024 00:10:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="chRGcC4j"
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFA762914
	for <linux-kernel@vger.kernel.org>; Sat,  6 Apr 2024 00:10:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712362229; cv=none; b=Pb+sbtFfwoiYV89eRcf5NCSXQFCtmte797g9FIuO87vL70CE8vobpNxvN4uKDDJS2QhtGZyBrgW2DloPIOF7Qnov5f02u+2LxZ7kUxcEwMjSdoBpqq+8X65GTBJQklaX34BZhoh7oFbiSr2dyC33QS/Th7aSYbCdO4cOzhTmrfc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712362229; c=relaxed/simple;
	bh=RXdNEB1oT1yf6rwW1pFfu1ElLCrmLjZDiwR36gM3NZs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OkJcgRREESqnj2Ax7jJ0hzmjFpzRM0Es+1ljO0uWh9k1bSLZyMHYx2f8FQFLZ3oAZB5ScX88NDdsD5T8u/ghtyvUhuK3kMpJRb201JehvnJ/O/rqL3X4QZAVfVwWSziqEUY0oA1RvjKHNVnET2kh/tvlE+8QlzcNLiwt1hruLyA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=chRGcC4j; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=8aksZsg0lLm9f0Q30PU9tPMqK5YvGvMj/voMhZ2RUDM=; b=chRGcC4jS1GHiE8Y9y0zVHSDI1
	m1nQGZBjfka83eIDULjOqO5riBOJ15wzYCx99N/cPx90q4bsBoV8ksUMGcfePgUoHIqlCD8eid22k
	pMlN6sr4qWitRuQZITLwOLx5VNZjQKmAjyyDih0+xoUIE8MG5lved9iA0rUgMtu+GQBzM8dp8IcWW
	Ko4bpODRP7SjdnHJYRDfYEKrqWhRG8v2MlMx1/B38JLSJLhD4LNgn+foO6zAE9SA1HI0Xn5oVQ+1F
	w9tyn/XqyTuMibeLMGvngtdA/zz8HhMpo2QjeEj5BSZriBliGwLBGEEv2d6PonpqSmr7FiYodc3BY
	4J4mq1/A==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
	id 1rstdT-006iwM-36;
	Sat, 06 Apr 2024 00:10:20 +0000
Date: Sat, 6 Apr 2024 01:10:19 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: syzbot <syzbot+9a5b0ced8b1bfb238b56@syzkaller.appspotmail.com>
Cc: hdanton@sina.com, linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [kernfs?] possible deadlock in kernfs_fop_llseek
Message-ID: <20240406001019.GV538574@ZenIV>
References: <20240405230034.1015-1-hdanton@sina.com>
 <000000000000a98dc7061561716f@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <000000000000a98dc7061561716f@google.com>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Fri, Apr 05, 2024 at 04:02:03PM -0700, syzbot wrote:
> Hello,
> 
> syzbot tried to test the proposed patch but the build/boot failed:
> 
> failed to apply patch:
> checking file fs/overlayfs/util.c
> Hunk #1 FAILED at 639.
> 1 out of 1 hunk FAILED

Heh...

ed fs/kernfs/file.c <<'EOF'
/mutex_init/a
	else if (file->f_mode & FMODE_WRITE)
		mutex_init(&of->mutex);
.
w
q
EOF

(and if the bot is willing to apply that kind of patches, we have a security
problem on hands ;-)

