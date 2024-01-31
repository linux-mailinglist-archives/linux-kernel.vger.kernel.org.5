Return-Path: <linux-kernel+bounces-45835-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C1968436C4
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 07:30:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3E9471C245D6
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 06:30:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36FDC3EA9E;
	Wed, 31 Jan 2024 06:29:57 +0000 (UTC)
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8375B3EA8A
	for <linux-kernel@vger.kernel.org>; Wed, 31 Jan 2024 06:29:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706682596; cv=none; b=AFPBdRmTWgOT2SpZaSIc7cYTnZFJCK7/oNfBpHPIK9Ce+y+4OqNrH2PvHmaQj+J/ybotIjO/wT6lhYvVyQKt793MqDFbnxz23gIEomgM8kZXa9sz9HP5NnHfbFNHvkQ1611qGUy/AV2SC1sy6gnB6CuDMBEAT3I5ECeV5Rqi/dU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706682596; c=relaxed/simple;
	bh=bPQ61G7MZUOuUbadWgz9AMo0/HH5TEmWR1yz0rGbrdw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=A0dEECYl1j4cudvtwqRmaD1ydfhN3lHYKOIlkSMvzaLqZ5qW41QYzEJpazJCRVcA2o7G7aWXrbmEo8VL6SVXVxKNGFoLUJGBjuaYNs2HWKzeTZjwTpDzouZvlrQttzFYrqQKXddSfMKGok85/WfPVGbcFkXWk8rItq36g+RLjK8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 8C98168B05; Wed, 31 Jan 2024 07:29:52 +0100 (CET)
Date: Wed, 31 Jan 2024 07:29:52 +0100
From: Christoph Hellwig <hch@lst.de>
To: Daniel Wagner <dwagner@suse.de>
Cc: James Smart <james.smart@broadcom.com>, Keith Busch <kbusch@kernel.org>,
	Christoph Hellwig <hch@lst.de>, Hannes Reinecke <hare@suse.de>,
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 12/12] nvmet-fc: use RCU list iterator for assoc_list
Message-ID: <20240131062952.GK16225@lst.de>
References: <20240130094938.1575-1-dwagner@suse.de> <20240130094938.1575-13-dwagner@suse.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240130094938.1575-13-dwagner@suse.de>
User-Agent: Mutt/1.5.17 (2007-11-01)

> +		list_for_each_entry_rcu(tmpassoc, &tgtport->assoc_list, a_list) {

please avoid the overly long line.

Also in general the (rcu)lock, list walk to find something, return
patterns tend to benefit from being factored into a little helper.
Not sure if that really fits here, though.


