Return-Path: <linux-kernel+bounces-79418-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 23C0B8621C2
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Feb 2024 02:18:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 55D451C21034
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Feb 2024 01:18:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF43AD51D;
	Sat, 24 Feb 2024 01:17:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JHfHHYY0"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE75FAD4E;
	Sat, 24 Feb 2024 01:17:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708737460; cv=none; b=YSKEMd9U9YmQNHsR1EogAx8bqpCVJdwfWOa6EQd+2GD03zRaniv2q9JIb9J8wtKLDIIJp2NjEL2toLHHlu4NXIhnwMZOIeYSB49fE96xQ0Yj3npoMcMX8nJVZCWG+nMZYRhM+3Tn/PQSvTiRoVKXnUVp42EqAuniyr/hx76h4+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708737460; c=relaxed/simple;
	bh=ZFtseLCUuaQeCSzQKjfhYeUT0c1H+3VXLY2EjIC2gqg=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BzbUXNEM9NK/S7kGqe4zR9UiBUBSyfZ5dHX3Gs6honJJw3AsVBEaf1xMyZZD9Q7WlwVax/q6APDYls4M/8JrlLZzVkwy0tq2yS+Ut2+6keNiZiE3GhwDzM1OqUhuClfVofN6Y5hMUc1WB5SxVIfMK3nInDqMNpVQOZFQblxmhdk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JHfHHYY0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 65A84C433F1;
	Sat, 24 Feb 2024 01:17:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708737459;
	bh=ZFtseLCUuaQeCSzQKjfhYeUT0c1H+3VXLY2EjIC2gqg=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=JHfHHYY0pcy3eZfzZLtZAZymX6JMLgMYlKhh2daVfMNrjmKMLcx4NN7u9pL/7k3ZY
	 D9daNNykjjngYcIAleD4RF+b0n6rN+22lYGz2dqXYx9NWFQEE33M3IPafaZGPVjEU8
	 bGOa4nvcp8M1/UuxB07GQwCmf4DACv0Y+QjPf7nVom5pT1jP2T8/mVQbFYKSTTO90m
	 IkvlE4ajj43pvt+frH7/T/oBFMNckXMwKMwIJeQYkPxXuTYLIeVguXu7mT0kBPBHCN
	 3jafYG6XjfWdXHsp9qbh3PXubGNpEdY7+dUKbNB+OWbw8Vl9w7uWh6WFlDnmdfJS/c
	 sTeVNrKWbg+Uw==
Date: Fri, 23 Feb 2024 17:17:39 -0800
Subject: [PATCH 5/5] thread_with_file: Fix missing va_end()
From: "Darrick J. Wong" <djwong@kernel.org>
To: akpm@linux-foundation.org, daniel@gluo.nz, kent.overstreet@linux.dev,
 djwong@kernel.org
Cc: linux-xfs@vger.kernel.org, linux-bcachefs@vger.kernel.org,
 linux-kernel@vger.kernel.org
Message-ID: <170873669481.1861696.7555634432474446443.stgit@frogsfrogsfrogs>
In-Reply-To: <170873669390.1861696.14195299906744951144.stgit@frogsfrogsfrogs>
References: <170873669390.1861696.14195299906744951144.stgit@frogsfrogsfrogs>
User-Agent: StGit/0.19
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

From: Kent Overstreet <kent.overstreet@linux.dev>

Fixes: https://lore.kernel.org/linux-bcachefs/202402131603.E953E2CF@keescook/T/#u
Signed-off-by: Kent Overstreet <kent.overstreet@linux.dev>
Reviewed-by: Darrick J. Wong <djwong@kernel.org>
Signed-off-by: Darrick J. Wong <djwong@kernel.org>
---
 lib/thread_with_file.c |    2 ++
 1 file changed, 2 insertions(+)


diff --git a/lib/thread_with_file.c b/lib/thread_with_file.c
index 8b129744a48a3..37a1ea22823ca 100644
--- a/lib/thread_with_file.c
+++ b/lib/thread_with_file.c
@@ -118,6 +118,8 @@ static ssize_t darray_vprintf(darray_char *out, gfp_t gfp, const char *fmt, va_l
 
 		va_copy(args2, args);
 		len = vsnprintf(out->data + out->nr, darray_room(*out), fmt, args2);
+		va_end(args2);
+
 		if (len + 1 <= darray_room(*out)) {
 			out->nr += len;
 			return len;


