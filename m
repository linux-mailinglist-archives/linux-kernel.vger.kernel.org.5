Return-Path: <linux-kernel+bounces-144785-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B010C8A4AB1
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 10:44:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 50DDC1F258FE
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 08:44:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 352ED39FF4;
	Mon, 15 Apr 2024 08:44:36 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAF6E241E1;
	Mon, 15 Apr 2024 08:44:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713170675; cv=none; b=j5d1IK861s/yE/GcI5BhdTGjtLCuYssCoWBl3V0oaWwZ6ZoYC7ZhLekYzhITF2q46vCXdu6RqY1uy0C/p6lL5xcnvLUCSy1tCPdYkKhwEeIAfBHMZ4G7ytuD9ekNX3t9Zj55rBb9MbSCiTLcinKWK0pB9DtygjzOmHMrlb4LkzQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713170675; c=relaxed/simple;
	bh=DBBTnXISGqvnEtKSDNsrMZDg6GcbyuEhLTHRaOSoMII=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=befL5WANmAjg1fLLu0YaSEuN6RuSgYJ+TiaO6J4r7JfPRJCEdl1I7TYrw+0fH3jRYXjPYNusWwagwtkf4UoxAi3pl5eQIh+y+2IiCuu6krlHF/mFa2n/jng2LCs6IfpoTBYcxpPgjvDGbHtUrKduT6xHnPuV9DMmMyFMSg1kgr8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30D34C113CC;
	Mon, 15 Apr 2024 08:44:34 +0000 (UTC)
Date: Mon, 15 Apr 2024 04:44:30 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Luca Ceresoli <luca.ceresoli@bootlin.com>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, Liam Girdwood <lgirdwood@gmail.com>,
 Mark Brown <broonie@kernel.org>, Thomas Petazzoni
 <thomas.petazzoni@bootlin.com>
Subject: Re: TP_printk() bug with %c, and more?
Message-ID: <20240415044431.308f2e09@rorschach.local.home>
In-Reply-To: <20240318164307.53c5595f@booty>
References: <20240315174900.14418f22@booty>
	<20240315132146.29edf416@gandalf.local.home>
	<20240315190312.2bd6a198@booty>
	<20240315145852.46125ac5@gandalf.local.home>
	<20240318164307.53c5595f@booty>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 18 Mar 2024 16:43:07 +0100
Luca Ceresoli <luca.ceresoli@bootlin.com> wrote:

> However the arrows are still reversed.

This requires a kernel change. The problem is that the print fmt has:

print fmt: "%c%s %s %s %s %s", (int) REC->path_node && (int) REC->path_connect ? '*' : ' ', __get_str(wname), (((REC->path_dir) == SND_SOC_DAPM_DIR_OUT) ? "->" : "<-"), __get_str(pname), (((REC->path_dir) == SND_SOC_DAPM_DIR_OUT) ? "->" : "<-"), __get_str(pnname)

User space (trace-cmd and perf) have no idea what SND_SOC_DAPM_DIR_OUT
is. The kernel needs to convert that, otherwise the parsing will fail,
or it will default it to zero.

-- Steve

