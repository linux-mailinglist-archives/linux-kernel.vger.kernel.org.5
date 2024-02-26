Return-Path: <linux-kernel+bounces-80987-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 821D3866EAB
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 10:36:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1FD9B1F240D4
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 09:36:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 447BC65E02;
	Mon, 26 Feb 2024 08:56:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="MlKzLYpB"
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38906657AB;
	Mon, 26 Feb 2024 08:56:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708937799; cv=none; b=Wby679PE1gS6lP89Zj6AkiapspRrKlavcD52Bl7yfEbqkVscWLNNOsVrzfE17QhD/fR7/k4aNf5J5GYo4cgmkZ+8vwgntc+DIC+oH05BQbXlcTb+AdIAeyxosh/gBfgkYf3AdEi6w9j0FQ2lMBqg+O49DPW3SDhoGMABO4/h7r8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708937799; c=relaxed/simple;
	bh=L6CHEGlhsuzkEAmo4qw//S6pN8Ig+3c1m4h3bULYjgM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nt0TSR7PMfDQmVa4rZXc8DGoZdo4yrGXEv5a8DsQV8symZGVT10hjIcjxgB3zVodDOURcX0rvBHPS4SfBS9gp/S62/f2dKTQMfs82p7Ohwvc5SAHAX3vJ3hdfIi7nLkKPtnzI5Hz3Ykna1ECp50tHk52M1q7ydysg9VN8a/L2Pw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=MlKzLYpB; arc=none smtp.client-ip=217.70.183.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 2A0111BF20E;
	Mon, 26 Feb 2024 08:56:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1708937795;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=H5CmrG0riakMiAQQzlijgsR/JH+Un/tJwWU9j0SetWg=;
	b=MlKzLYpBbC0N09wIaaNbg1nF56lt+35GmhdwKqhITk0uDztfJSeSNL5g17pq605VTd8zbH
	hr+Nuqg1PgkF2w2xGkjdr+jCZYjbhVgCAfBFtCjseJDtiUTd06ThGmVCeY2QySBmhvrTWS
	Ag46SIqwjDginFrDvdZFiFiopXwottOd5sUqv4Zl7VHR4FyBcHgi6/igysE677t9x1KW5D
	1/eJLCFVmaycUffNKRpHBOnwiFM6DVMsVdggWSFqCeGjIOEC9Md4BWUQ4ygKBoy9SfvNT9
	X//YPmu/V8VQTHFCSMZRsr9TdTeKb4ZOJ3gd6NG8AH8+veIOD0wf3iaT4uF7PQ==
Date: Mon, 26 Feb 2024 09:56:34 +0100
From: Herve Codina <herve.codina@bootlin.com>
To: Saravana Kannan <saravanak@google.com>
Cc: Rob Herring <robh+dt@kernel.org>, Frank Rowand <frowand.list@gmail.com>,
 Luca Ceresoli <luca.ceresoli@bootlin.com>, kernel-team@android.com, Rob
 Herring <robh@kernel.org>, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] of: property: fw_devlink: Fix stupid bug in
 remote-endpoint parsing
Message-ID: <20240226095634.67f2f501@bootlin.com>
In-Reply-To: <20240224052436.3552333-1-saravanak@google.com>
References: <20240224052436.3552333-1-saravanak@google.com>
Organization: Bootlin
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-GND-Sasl: herve.codina@bootlin.com

Hi Saravana,

On Fri, 23 Feb 2024 21:24:35 -0800
Saravana Kannan <saravanak@google.com> wrote:

> Introduced a stupid bug in commit 782bfd03c3ae ("of: property: Improve
> finding the supplier of a remote-endpoint property") due to a last minute
> incorrect edit of "index !=0" into "!index". This patch fixes it to be
> "index > 0" to match the comment right next to it.
> 
> Reported-by: Luca Ceresoli <luca.ceresoli@bootlin.com>
> Link: https://lore.kernel.org/lkml/20240223171849.10f9901d@booty/
> Fixes: 782bfd03c3ae ("of: property: Improve finding the supplier of a remote-endpoint property")
> Signed-off-by: Saravana Kannan <saravanak@google.com>
> ---
> Using Link: instead of Closes: because Luca reported two separate issues.
> 
> Sorry about introducing a stupid bug in an -rcX Rob.
> 

Reviewed-by: Herve Codina <herve.codina@bootlin.com>

Best regards,
Hervé

