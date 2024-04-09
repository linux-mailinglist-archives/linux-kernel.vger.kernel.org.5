Return-Path: <linux-kernel+bounces-137235-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 49CC589DF45
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 17:35:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7B2471C22379
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 15:35:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 958E9135A56;
	Tue,  9 Apr 2024 15:32:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KgOJ6l2O"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4B7F12D1E7;
	Tue,  9 Apr 2024 15:32:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712676726; cv=none; b=foT4JrR8navTCUdHYb8wCeXyUlin1hJitUoEPGV0ubrfSe3qgrDfHwwLu2tYdv0GTOplWdyrkmUvuYVCTyn845aHtsPOjpSaVCnzLuqug8kbieT/0GoKsmNQFEpZ2LYuMESg+rSUP9iXRf/PQBtd0Y1X4LrnF+vDnTLO0ImDsw0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712676726; c=relaxed/simple;
	bh=Dschz1gJNw4+/0FWjY5GsFcl2UP4wt6UsR+ejRfU6Xw=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=Ja6TUnrqlvCnMJ5baZVug9IUnj+VNM2BkkOaKNLiN4oRbJBKqMB/vsoSXWmZijfUnCXQYNKwaFLg9hAcWVBT7TRpxAYwEVBP/5tubvJISPkQ7Sg6nI7W5aNVIDEzwn/A29NCwnnzq44mpNNYArbBSEX1PCl08j6YXUKu6Kujd50=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KgOJ6l2O; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06432C433F1;
	Tue,  9 Apr 2024 15:32:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712676726;
	bh=Dschz1gJNw4+/0FWjY5GsFcl2UP4wt6UsR+ejRfU6Xw=;
	h=Date:From:To:Cc:Subject:From;
	b=KgOJ6l2OUGMgXBC4fuzMl5zGoe1zVJGfeouFgQXiLzZD3wIhgmDPSM/Mg0gMD4Ztg
	 6/XwIb68fZWUT4xe+qX2U0NwhsiI3/Nx8lSV85OOlOoF/zUvPx7Zp7jiym49N7/pOT
	 KNLUIq6Ni9yBeUuGxhprY4Az1tKa+cKkrLG+f6+yjE11IxYGxFnoH+LGjAaR05ro8X
	 KOuasHvfu810u3PRszkrI/QOLprRWme7EuBZlXsBb03GC+W9Fa/jRi1IozF0zpMOsw
	 9zaK64oZ3uUGsd4Aph/546AYrk7UwITU0MXJMWIcEHBSd6BzUOOurbxtItchktoabg
	 cQGElHeQwxwog==
Date: Tue, 9 Apr 2024 12:32:03 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
	linux-perf-users@vger.kernel.org,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: BISECTED: perf test 'Miscellaneous Intel PT' failing on Intel hybrid
 machines
Message-ID: <ZhVfc5jYLarnGzKa@x1>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

root@x1:~# perf test "Miscellaneous Intel PT testing"
112: Miscellaneous Intel PT testing                                  : FAILED!
root@x1:~#

then I revert:

commit 642e1ac96aaa12aeb41402e68eac7faf5917a67a (HEAD -> perf-tools-next)
Author: Arnaldo Carvalho de Melo <acme@redhat.com>
Date:   Tue Apr 9 12:28:49 2024 -0300

    Revert "perf pmus: Check if we can encode the PMU number in perf_event_attr.type"
    
    This reverts commit 82fe2e45cdb00de4fa648050ae33bdadf9b3294a.
⬢[acme@toolbox perf-tools-next]$

It works now:

root@x1:~# perf -v
perf version 6.8.g642e1ac96aaa
root@x1:~# perf test "Miscellaneous Intel PT testing"
117: Miscellaneous Intel PT testing                                  : Ok
root@x1:~#

Investigating, if you come up with ideas, lemme know.

- Arnaldo

