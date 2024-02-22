Return-Path: <linux-kernel+bounces-76510-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4674B85F81E
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 13:25:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 01AB528449A
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 12:25:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEFF951031;
	Thu, 22 Feb 2024 12:25:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y90FYbRZ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 208355FBA5;
	Thu, 22 Feb 2024 12:25:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708604742; cv=none; b=tABR5cWKjFOsWMrIB+Frh7CySvH2FG4ofYvnNE/Wr2ld7DK8KtKsnUKvWtepDWCg/e/vnv6AHt0eU5wFBghjOd+xIKyIbq75XCMQ1vXG3qn7pY7/WuRTP/Xc68h6XQaWOAbBv00kjhxzI3dbllngUjcH8ek9V7q/x80bG1XPmpA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708604742; c=relaxed/simple;
	bh=aGAfs6jmsNG6QGI752Z3kOdPKVMUa2RCagcGhOm450c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=T+n3QiEvCWlvH1LIl8sewG69A5fU80MORTHS/Jq5lUO2liOfGZVtK5VIXJdIRfueKfKlwxS4qfwVsTvZPJamesyr0jPiHAq1JARlZIscx6RuGlAqNRt2HIO2F1VqFUecudpu8rodivDdNqn9GkMBco4T589oqthdTLdulg3fOlE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y90FYbRZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F024AC433C7;
	Thu, 22 Feb 2024 12:25:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708604741;
	bh=aGAfs6jmsNG6QGI752Z3kOdPKVMUa2RCagcGhOm450c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Y90FYbRZxnZ2Rg/dECWSnrAORMVngwV8sBdRfaaDCmbK4STyurf8m20j/N7QO8vrE
	 9DGu0JGOdw2LFrPXdzpgwUov1BkWbz77XhKsVG8YTV37knB6Yl3lVpk6apXsRyaARY
	 BwzpuWH7tbblNcEOezIQ2rNBShSTGt5oUf0oakprvJyXeoEjOMJ9xzxuTuu7aqCHsI
	 w6JdeCoTHgItp68w2jJ78EXsmTdNDTGIs9bsyQTmvbmgWPEet+BPrrMssmenUrMvL6
	 psnJogKojzVc4/wh9iDGS8C3eSMn7av8utNixGM33TptmejAtbNs0HlxMmOc2z4wPg
	 qPF0AD4TBu7Lw==
Date: Thu, 22 Feb 2024 12:25:33 +0000
From: Will Deacon <will@kernel.org>
To: Xu Yang <xu.yang_2@nxp.com>
Cc: Frank.li@nxp.com, mark.rutland@arm.com, robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
	shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
	festevam@gmail.com, john.g.garry@oracle.com, jolsa@kernel.org,
	namhyung@kernel.org, irogers@google.com, linux-imx@nxp.com,
	mike.leach@linaro.org, leo.yan@linaro.org, peterz@infradead.org,
	mingo@redhat.com, acme@kernel.org,
	alexander.shishkin@linux.intel.com, adrian.hunter@intel.com,
	linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
	imx@lists.linux.dev
Subject: Re: [PATCH v4 6/6] perf vendor events arm64:: Add i.MX95 DDR
 Performane Monitor metrics
Message-ID: <20240222122533.GE8308@willie-the-truck>
References: <20240131055811.3035741-1-xu.yang_2@nxp.com>
 <20240131055811.3035741-6-xu.yang_2@nxp.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240131055811.3035741-6-xu.yang_2@nxp.com>
User-Agent: Mutt/1.10.1 (2018-07-13)

On Wed, Jan 31, 2024 at 01:58:11PM +0800, Xu Yang wrote:
> Add JSON metrics for i.MX95 DDR Performane Monitor.

(nit: "Performane" => "Performance" here and in the subject)

Will

