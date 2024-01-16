Return-Path: <linux-kernel+bounces-28285-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D380682FC87
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 23:22:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 858D91F2A447
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 22:22:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 266892D041;
	Tue, 16 Jan 2024 21:12:39 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9728528E0F;
	Tue, 16 Jan 2024 21:12:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705439558; cv=none; b=hAJd5Teo0p6o78Z2tG5u09M8+JNmE7bFbLrnldtaLoSdpgvkoS1lZhqmmORaplh5kAq2c3rOv947DGWPaoRZEwv8iFefWtuKP/6qouW1vcYOXNwzxfy8Qx31cshoZ1OWbgdyMnDjdB5qngbDBsJQcGM5/h31DocQQKLwYvEIKMA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705439558; c=relaxed/simple;
	bh=XwadrmOrptVsYu7IxUJQMzwypbu8gdBaHUCKGKRfuVc=;
	h=Received:Received:Message-ID:User-Agent:Date:From:To:Cc:Subject;
	b=YaefpehqH5NhVsYtNiWwvLjGm2s95pJRuBOYjkcfHYg7Vdd8yzQl3K5hvDboTu6lQZ3AyRvALCgq5fhJE7UWBGIhmtQB23Gh1Omsrt8yuAIuxz1ReK4UxFH7hauiFmMxA19ZN6GzXsDh8MYXmyj+eN6pMNBJei8pKHsI7GE1PNM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36AE9C433C7;
	Tue, 16 Jan 2024 21:12:38 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.97)
	(envelope-from <rostedt@goodmis.org>)
	id 1rPqkr-00000001PQS-1bov;
	Tue, 16 Jan 2024 16:13:53 -0500
Message-ID: <20240116211217.968123837@goodmis.org>
User-Agent: quilt/0.67
Date: Tue, 16 Jan 2024 16:12:17 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 Christian Brauner <brauner@kernel.org>,
 Al  Viro <viro@ZenIV.linux.org.uk>,
 Ajay Kaher <ajay.kaher@broadcom.com>,
 linux-fsdevel@vger.kernel.org
Subject: [PATCH v2 0/2] eventfs: Create dentries and inodes at dir open
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

[ subject is wrong, but is to match v1, see patch 2 for correct subject ]

Fix reading dir again, this time without creating dentries and inodes.

Changes since v1: https://lore.kernel.org/linux-trace-kernel/20240116114711.7e8637be@gandalf.local.home


Steven Rostedt (Google) (2):
      eventfs: Have the inodes all for files and directories all be the same
      eventfs: Create list of files and directories at dir open

----
 fs/tracefs/event_inode.c | 223 +++++++++++++++++++++++++++++++++--------------
 1 file changed, 159 insertions(+), 64 deletions(-)

