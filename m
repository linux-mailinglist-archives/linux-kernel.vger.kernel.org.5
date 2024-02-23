Return-Path: <linux-kernel+bounces-77627-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 523A686083E
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 02:32:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3CAFA1C21D3E
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 01:32:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9630B66B;
	Fri, 23 Feb 2024 01:31:53 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AA869470;
	Fri, 23 Feb 2024 01:31:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708651913; cv=none; b=mlcANNv6E+tcEBEiEBWhQVGwahnNBEW9KA9Z8vTbPupTxByir2d5Cb2cG2If0OowD8cpLxHX1vkSDcLcyjlOejH4TqTujtEDmu1lPzRXZ5TsBmfkup9MIMXBC42zs6+ZyCsnQRSWE6GWCmD4nj0tni2S4xxgfh12USltB6Aiiyc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708651913; c=relaxed/simple;
	bh=vsgQXvFzIGZYJuAH8O4F9NAg1U6Ack1SewN87diLNIQ=;
	h=Message-ID:Date:From:To:Cc:Subject; b=qCCjDARWqjME5ChLLdslkSliVt0qImv4cPs4eug14VPQqpDDGXfhpysmy+nNAerBKyFGt9/GAyRvJV6GvR+mHN23Uc8GDoW1TsXrLfHnyWcwhao6+fhONrAYhq2m+zeu80cKSjubIqw05daHp/BltmxgpSVx/M3E72b19UBvt7w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02708C433C7;
	Fri, 23 Feb 2024 01:31:52 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.97)
	(envelope-from <rostedt@goodmis.org>)
	id 1rdKRc-00000006ofb-2Gce;
	Thu, 22 Feb 2024 20:33:44 -0500
Message-ID: <20240223013323.798805901@goodmis.org>
User-Agent: quilt/0.67
Date: Thu, 22 Feb 2024 20:33:23 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Vincent Donnefort <vdonnefort@google.com>
Subject: [PATCH 0/2] tracing: Fix snapshot accounting
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>


The ring buffer mapping test failed after running the ftrace tests.
This was due to some mismatched snapshot accounting that left the
snapshot counter enabled when it was not, which prevents the ring buffer
from being mapped.

Steven Rostedt (Google) (2):
      tracing: Fix snapshot counter going between two tracers that use it
      tracing: Decrement the snapshot if the snapshot trigger fails to register

----
 kernel/trace/trace.c                | 2 +-
 kernel/trace/trace_events_trigger.c | 5 ++++-
 2 files changed, 5 insertions(+), 2 deletions(-)

