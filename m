Return-Path: <linux-kernel+bounces-28380-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EAC0582FDCA
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 00:39:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1E2061C25460
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 23:39:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19C0A1D68B;
	Tue, 16 Jan 2024 23:39:00 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FD5B1B97E;
	Tue, 16 Jan 2024 23:38:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705448339; cv=none; b=foWAQMNNm+9mAUJyAZZjUOMzf1PPJzk0Epnym8jPt17L96+Z3O0wx+2MSfr+4qZXOW/1kDiAaWG3BFre5vUD3ly2V0kmooLj7cGHUuc8hmBGc6IFQdBzu6eJ5PV2rhb/RGsiSmbWF3+YQhU0dRHJHy7OcB57pkMHSHl7G8+KaD0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705448339; c=relaxed/simple;
	bh=6l2vQhaSNTjzOkqIsLgNiqauhtFEnfkDj9/gvBjGMIg=;
	h=Received:Received:Message-ID:User-Agent:Date:From:To:Cc:Subject;
	b=Q5T6N3B431Ht2IgdTZVECsFeEwJbexRLccqTltq+Ru7R6OQkgCxsAb8ImjLnHwrX2ocsYJjPMZpHPrGYGIEeyhYlg1G8hrzI8HKt7YMojjs7OXyEneOgyfltuvWXWAGlpunEseuH6g0zpW0K1K9DD/aHsS2Ol5wW/vQiQyrwxW4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 13828C43394;
	Tue, 16 Jan 2024 23:38:59 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.97)
	(envelope-from <rostedt@goodmis.org>)
	id 1rPt2U-00000001QeI-1nuj;
	Tue, 16 Jan 2024 18:40:14 -0500
Message-ID: <20240116225531.681181743@goodmis.org>
User-Agent: quilt/0.67
Date: Tue, 16 Jan 2024 17:55:31 -0500
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
Subject: [PATCH v3 0/2] eventfs: Create dentries and inodes at dir open
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>


[ subject is still wrong, but is to match v2, see patch 2 for correct subject ]


Changes since v2: https://lore.kernel.org/all/20240116211217.968123837@goodmis.org/

Implemented Linus's suggestion to just change the iterate_shared to
use the hard coded inodes.


Steven Rostedt (Google) (2):
      eventfs: Have the inodes all for files and directories all be the same
      eventfs: Do not create dentries nor inodes in iterate_shared

----
 fs/tracefs/event_inode.c | 30 +++++++++++++++---------------
 1 file changed, 15 insertions(+), 15 deletions(-)

