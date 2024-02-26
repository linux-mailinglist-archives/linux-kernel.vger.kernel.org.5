Return-Path: <linux-kernel+bounces-80744-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A0D11866BF9
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 09:19:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D22D51C22BDD
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 08:19:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F2D21CAA5;
	Mon, 26 Feb 2024 08:19:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="edDb6HqW"
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EBD71C6A3;
	Mon, 26 Feb 2024 08:19:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708935584; cv=none; b=OkylQflu1ibdtctJnNHDQY048TCHJyV79pNYtfIJvMEhor4DBHBso4F1VRy/esZss+7fuKLVil0ywChuyt9M9OPCDOo0NUhVjrfOBbc3Hp8HBJCFBoEBxnbiSeHZOOHdZeza2mX4hykw1rojABFWmgyZBoXCviz0xURSjlmWkiI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708935584; c=relaxed/simple;
	bh=ll48MJwAP66eEE4I1mxVSojHViPUkd6NS79nXsjLCi0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PQg4QAsY3d3/z4k8t7473NiOQA9rIk7LwJ+C2ILla7DFrVgsF02aBAhZ2vKgKTNIx2nV215reTUBM41QTAQwaKXanthEY/QIat0m+Z74fuc0RjxlUz9wDiCfCgEGvbrd9NhNp14VIkEMMK3tvbJ0ylfJEKNn9jDPnjZUX/Rx9kM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=edDb6HqW; arc=none smtp.client-ip=217.70.183.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id B1B221BF20A;
	Mon, 26 Feb 2024 08:19:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1708935574;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lIvDXxGeo51SInc9MmWiuWKt5CaioIotY1PibSab+q4=;
	b=edDb6HqW+23DlG3IR4K7W1sKpq7+g2Mi4GEa9/PHxn471OHUsIfql/37IOwKqYQcmckmJy
	9CwLpZOVAx2+K3ATxpKSmns9PRxwjW47tdx62GkQyUtY1RmvvV8CJM3hLD5aB/SJGmpR0a
	Lo15g3MVTuAlsHCu3BFQ6JkUyQVFNuW0lHXRduc7xf2XlXGKlhZotXgMdWGxSxI/DtyjNR
	71G/IqLSe7UvOs0TzfIT75FzfbrY7xhOBHErauIzB/WTMdkZTzAmul0GHjPGZsEHvRsUPS
	H1gqEWyFtoWQSZH03MPQsVIK0/FYoluH8M/9stD9HzPiV9QeoKNwYTf/ZTIAbw==
Date: Mon, 26 Feb 2024 09:19:32 +0100
From: Luca Ceresoli <luca.ceresoli@bootlin.com>
To: Saravana Kannan <saravanak@google.com>
Cc: Rob Herring <robh+dt@kernel.org>, Frank Rowand <frowand.list@gmail.com>,
 "=?UTF-8?Q?Herv=C3=A9?= Codina" <herve.codina@bootlin.com>,
 kernel-team@android.com, Rob Herring <robh@kernel.org>,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] of: property: fw_devlink: Fix stupid bug in
 remote-endpoint parsing
Message-ID: <20240226091932.3f39e2c5@booty>
In-Reply-To: <20240224052436.3552333-1-saravanak@google.com>
References: <20240224052436.3552333-1-saravanak@google.com>
Organization: Bootlin
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-GND-Sasl: luca.ceresoli@bootlin.com

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

Reviewed-by: Luca Ceresoli <luca.ceresoli@bootlin.com>
Tested-by: Luca Ceresoli <luca.ceresoli@bootlin.com>

-- 
Luca Ceresoli, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

