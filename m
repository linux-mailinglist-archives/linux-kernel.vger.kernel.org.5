Return-Path: <linux-kernel+bounces-32932-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CC5B836219
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 12:40:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D9A67296DCA
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 11:40:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7A6746441;
	Mon, 22 Jan 2024 11:31:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ispras.ru header.i=@ispras.ru header.b="pnxknEsH"
Received: from mail.ispras.ru (mail.ispras.ru [83.149.199.84])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D425746436;
	Mon, 22 Jan 2024 11:31:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.149.199.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705923113; cv=none; b=XJO4w29y6CRS/3frualQ+p8VJBNPEg3xXVXntxsPFk9lF9rwWSaXs+y/ONESTVJ/WF0ItC3oXJibj2F36VdWSZDnX35qjdDvZpE74Um0o1XROL9vfh1oc4ZKQeHmijy7+lEpIheKt2X6Udf3+izXl5cvZ8GRDg00L0FrFsXahKk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705923113; c=relaxed/simple;
	bh=60nxEBSxqbfPA2QluD91mojuQuMg3LEb/O9WIHIV/PE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=k44pj97BjtyIbWEh6ky0dpr1rVuD+BEniMnWALE8eTpmomh2tn3ldoxAfGwu7NuVIEmmAJVdBCyMN4TH6zchecXfdL7c6itf9kgY2RPxHPtdaNtWIOTMTlLu0yu5xbQXf10Koyniky/gdkuSp7PDM5NYstT9APTx1MaLfXbJOhw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ispras.ru; spf=pass smtp.mailfrom=ispras.ru; dkim=pass (1024-bit key) header.d=ispras.ru header.i=@ispras.ru header.b=pnxknEsH; arc=none smtp.client-ip=83.149.199.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ispras.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ispras.ru
Received: from fpc.intra.ispras.ru (unknown [10.10.165.9])
	by mail.ispras.ru (Postfix) with ESMTPSA id 8321640755C3;
	Mon, 22 Jan 2024 11:31:45 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.ispras.ru 8321640755C3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ispras.ru;
	s=default; t=1705923105;
	bh=60nxEBSxqbfPA2QluD91mojuQuMg3LEb/O9WIHIV/PE=;
	h=From:To:Cc:Subject:Date:From;
	b=pnxknEsHBsuqGvUdF2KXy58Axzvc93jkzAQKcDRozaMCJUFd4C9K+oOv1VnH15iEf
	 3L42u0+Rhn24DRdWacDpUkVnBO2WTH/mj1MwE7sgmC5KQisn4sEuF2XwHFNAtci4ie
	 YzYmE6mfaK7z7VIcc5bXyi8/HUdVs/7PUYiz34pI=
From: Fedor Pchelkin <pchelkin@ispras.ru>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org
Cc: Fedor Pchelkin <pchelkin@ispras.ru>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	"Steven Rostedt (Google)" <rostedt@goodmis.org>,
	linux-kernel@vger.kernel.org,
	lvc-project@linuxtesting.org
Subject: [PATCH 5.10/5.15 0/1] kprobes: Fix to handle forcibly unoptimized kprobes on freeing_list
Date: Mon, 22 Jan 2024 14:30:30 +0300
Message-Id: <20240122113031.301202-1-pchelkin@ispras.ru>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The `WARNING in kprobe_optimizer` is reproduced on 5.10/5.15 stable
branches.

The problem ([1], link included in original commit description) has been
fixed by the following patch which can be cleanly applied to 5.10/5.15.
The fix is already present in all stable branches starting from 6.1.

Link to the "failed to apply to 5.15" report [2].
Link to the "failed to apply to 5.10" report [3].

[1]: https://lore.kernel.org/all/Y8URdIfVr3pq2X8w@xpf.sh.intel.com/
[2]: https://lore.kernel.org/stable/16781827629218@kroah.com/
[3]: https://lore.kernel.org/stable/16781827635613@kroah.com/

