Return-Path: <linux-kernel+bounces-121119-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B1BD88E28B
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 14:29:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B82EB29A708
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 13:29:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0B4F172BC7;
	Wed, 27 Mar 2024 12:22:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="Ssdt28OT";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="T238+SQL";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="Ssdt28OT";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="T238+SQL"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C07513BC28
	for <linux-kernel@vger.kernel.org>; Wed, 27 Mar 2024 12:22:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711542130; cv=none; b=kyWxe0LexPJsXPdrFWtArjuBbUrKymid+Kb4Sbod1ZeEmyZmyMdDBFo9sUmPReJrb3LUJqbCy3K8HvKwlk6FOeNN6i4+KBo/t3YsdFN9W7bKhA3aZoPMsLuAnthn44thoQAziLt+PJy2zlLKBKjPXAMNrFG4sddHL99sO7Qp9hY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711542130; c=relaxed/simple;
	bh=Jy/9HP4HKK4M4X4eZcrJHQRu3OFUTPW5Tfvm+BXpQ9s=;
	h=From:To:Subject:CC:Date:Message-ID:MIME-Version:Content-Type; b=Kth3mUxHWoLFwmJTJQkbM84Uw99NuDwGlpsJ07jHvS4cW6dCGbd0zltl8KFZW/1ydQszAneGxP1my+qdeKyMkiOeC5J5wAgVyPBOvd32eKUn+gRHr5P1Wk6ojejzKPaAhV0HFg+J10XgN1YROFrXG6tfgVYzA7erHrRbk70tIuE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=Ssdt28OT; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=T238+SQL; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=Ssdt28OT; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=T238+SQL; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from hawking.nue2.suse.org (unknown [10.168.4.11])
	by smtp-out2.suse.de (Postfix) with ESMTP id 8DE77604F3;
	Wed, 27 Mar 2024 12:22:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1711542126; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type;
	bh=gM8O9BMvpmcweC/49S6T4WsOquW93fnYjM6IK+bwXKE=;
	b=Ssdt28OT7qmUKLV8uScEd66ypiVH1N+F5aNhuNO1pdtTDLKthe/NdnKwwUIRBrNYWbuhSK
	62GDE5ReODFKOz0CcWBy5WCMSIEjpu+AMO23TwXBW2eoZlZLQgHJz9g778LTBcAFizzeio
	RUioF3j4Tv/bvID9gjEXuAunOCS6eYI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1711542126;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type;
	bh=gM8O9BMvpmcweC/49S6T4WsOquW93fnYjM6IK+bwXKE=;
	b=T238+SQLURftQENgTnWvF65vJFoVbQlKraD9/dCFYuO1oaynJhrNiWDu98IQwa0xCCpc+s
	je9TJAvTDe1u7LDA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1711542126; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type;
	bh=gM8O9BMvpmcweC/49S6T4WsOquW93fnYjM6IK+bwXKE=;
	b=Ssdt28OT7qmUKLV8uScEd66ypiVH1N+F5aNhuNO1pdtTDLKthe/NdnKwwUIRBrNYWbuhSK
	62GDE5ReODFKOz0CcWBy5WCMSIEjpu+AMO23TwXBW2eoZlZLQgHJz9g778LTBcAFizzeio
	RUioF3j4Tv/bvID9gjEXuAunOCS6eYI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1711542126;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type;
	bh=gM8O9BMvpmcweC/49S6T4WsOquW93fnYjM6IK+bwXKE=;
	b=T238+SQLURftQENgTnWvF65vJFoVbQlKraD9/dCFYuO1oaynJhrNiWDu98IQwa0xCCpc+s
	je9TJAvTDe1u7LDA==
Received: by hawking.nue2.suse.org (Postfix, from userid 17005)
	id 53E954AACE2; Wed, 27 Mar 2024 13:21:36 +0100 (CET)
From: Andreas Schwab <schwab@suse.de>
To: linux-riscv@lists.infradead.org
Subject: 6.9-rc1 regression: irq: no irq domain found for
 interrupt-controller@c000000
CC: linux-kernel@vger.kernel.org
X-Yow: Eisenhower!!  Your mimeograph machine upsets my stomach!!
Date: Wed, 27 Mar 2024 13:21:36 +0100
Message-ID: <mvmplvfg90v.fsf@suse.de>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Authentication-Results: smtp-out2.suse.de;
	none
X-Spam-Level: 
X-Spam-Score: -1.29
X-Spamd-Result: default: False [-1.29 / 50.00];
	 ARC_NA(0.00)[];
	 BAYES_SPAM(0.01)[46.21%];
	 FROM_HAS_DN(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 MIME_GOOD(-0.10)[text/plain];
	 TO_DN_NONE(0.00)[];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 RCPT_COUNT_TWO(0.00)[2];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 RCVD_COUNT_ZERO(0.00)[0];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 MID_RHS_MATCH_FROM(0.00)[]
X-Spam-Flag: NO

The SiFive ccache driver fails to look up its irqs:

[    0.762329] irq: no irq domain found for interrupt-controller@c000000 !
[    0.769358] CCACHE: Could not request IRQ 0

This is fatal for the JH7100 based boards, since they depend on it for
their DMA noncoherence.

-- 
Andreas Schwab, SUSE Labs, schwab@suse.de
GPG Key fingerprint = 0196 BAD8 1CE9 1970 F4BE  1748 E4D4 88E3 0EEA B9D7
"And now for something completely different."

