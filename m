Return-Path: <linux-kernel+bounces-127851-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F8088951AE
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 13:20:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 611B21C2311C
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 11:20:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 878DB626A0;
	Tue,  2 Apr 2024 11:20:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="NnExroUT";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="lBv/XW6m"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 187CA5A4C7
	for <linux-kernel@vger.kernel.org>; Tue,  2 Apr 2024 11:20:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712056841; cv=none; b=E7ZVdsDgOYGEQaGWXe5IfGLipvvBkApwTz8d7H4BFiKOSG8ikLxri6kQhGTDZhorWYalegOzwr/dQy6io0UVGg0HoxqTuzKsCIuQNDQwXa+mBTiylQ1GoPD+4YA2WyeTmLoUfm5VXiQdMueYp4GLAZcDIu23dYhLx1OTFcOzrbk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712056841; c=relaxed/simple;
	bh=I6RChiJFjQVbbUTWSKLmo+I28HKacpVxofusIsEVe24=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=i/TK3W0rcN4SFZDU8pLltMy7pzSkqPlxPiXV13OEIq5YwCMdRQmozhOLVBLLqFpe9q5rxkwpQ3+2RidL2vWBpeIVVYZeOrpySl9DdLHNNnOEU//lt8w1EVbi+dL5g8xlEJ9xq8mhblIzCRcvB3NFF8Jms/7eRzK9MOD9PRli8u8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=NnExroUT; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=lBv/XW6m; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 52C6622419;
	Tue,  2 Apr 2024 11:20:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1712056838; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=apA0Uu4D1AgfLqcwFbImK2prYt2oHJJeyB/JlM/93O4=;
	b=NnExroUT5vh/JpIUPeU+/Mg0nEpSEqcSvofpvlMqhpkjGO4a0AX6onoxENkOrRCFsVB/ED
	J9tPeDE/m2BGDSM8cy/dnPENfLIaFlF/k1zxagj0zvUK4XNCpiRbWb+tf35M3W6NYJqudo
	CWY0Jxa0580cCwhVAZVDNefnfTvIQLo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1712056838;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=apA0Uu4D1AgfLqcwFbImK2prYt2oHJJeyB/JlM/93O4=;
	b=lBv/XW6mYKDUmkY/I0LALpdkywTpCO8tOoTCxrk/8M+0QNllVNsDrpjXe7tF7t9OwBr9HZ
	vTSo5OjReWMd82Cg==
Authentication-Results: smtp-out1.suse.de;
	dkim=none
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id D3E5B13357;
	Tue,  2 Apr 2024 11:20:37 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id UYQtMQXqC2YVKAAAn2gu4w
	(envelope-from <osalvador@suse.de>); Tue, 02 Apr 2024 11:20:37 +0000
Date: Tue, 2 Apr 2024 13:22:02 +0200
From: Oscar Salvador <osalvador@suse.de>
To: Vlastimil Babka <vbabka@suse.cz>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org, Michal Hocko <mhocko@suse.com>,
	Marco Elver <elver@google.com>,
	Andrey Konovalov <andreyknvl@gmail.com>,
	Alexander Potapenko <glider@google.com>
Subject: Re: [PATCH v3 3/3] mm,page_owner: Fix accounting of pages when
 migrating
Message-ID: <ZgvqWoZsYJLenSE_@localhost.localdomain>
References: <20240326063036.6242-1-osalvador@suse.de>
 <20240326063036.6242-4-osalvador@suse.de>
 <50f31489-b5c3-480e-a7db-20edbbb2c9c2@suse.cz>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <50f31489-b5c3-480e-a7db-20edbbb2c9c2@suse.cz>
X-Spam-Score: 0.31
X-Spamd-Bar: /
X-Spam-Flag: NO
X-Spamd-Result: default: False [0.31 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 FREEMAIL_ENVRCPT(0.00)[gmail.com];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	 NEURAL_HAM_LONG(-1.00)[-0.995];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 MX_GOOD(-0.01)[];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 RCPT_COUNT_SEVEN(0.00)[8];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 R_DKIM_NA(2.20)[];
	 MIME_TRACE(0.00)[0:+];
	 FREEMAIL_CC(0.00)[linux-foundation.org,vger.kernel.org,kvack.org,suse.com,google.com,gmail.com];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-0.59)[81.59%];
	 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:98:from]
X-Spam-Level: 
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 52C6622419

On Tue, Apr 02, 2024 at 12:26:51PM +0200, Vlastimil Babka wrote:
> Can the migration still fail after __folio_copy_owner()? That goes again to
> the comment you changed in patch 1/3. If it can, this will kinda create a
> mess with the old folio's handles not reflecting reality? (although
> refcounts will be ok)

According to my research (I replied in patch#1), no, migration cannot
fail after __folio_copy_owner(), so we are safe here (Tm).


-- 
Oscar Salvador
SUSE Labs

