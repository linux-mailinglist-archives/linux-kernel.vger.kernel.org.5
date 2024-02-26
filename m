Return-Path: <linux-kernel+bounces-81247-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B279867294
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 12:06:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6B90F1C24ED7
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 11:06:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14AA71CF92;
	Mon, 26 Feb 2024 11:06:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="p1MrETxd"
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F7DC1B966;
	Mon, 26 Feb 2024 11:06:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708945583; cv=none; b=dQaCCIRWAAxHP2CHA33RFDx7YAvfw1qs42ghBVoa7xb9TevFSrKzvDPCNoCm+lRZ9yXj/0+sqa7f5RUd6zOeg38j7Skjnk1xhMp7E9qjVPddRS+AQTWYt0DS8xIYM/1c8k36UyIWVcQfZZ4+pgPkuw/PmJawaNdezZNjiYkTsmE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708945583; c=relaxed/simple;
	bh=WHdbQnlfcOYTc10sxSqdjWKBT+rdFQUDsUt4B65OTok=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nyrMZg/jy31D+tfOZnQqBlW9shit5N6MZ986/WZJWx7GHvpGEuiROWQ2nQ9/5633VUHeuKQAu8ZWdI8j3n3YrYIbjr6dfQwUdDsduiMzvljY8ywkgHyDIgs1eiV4GmP/1fpOqrPmzPIiUAiqvraBOsViLMj4fe43WVw521jFu68=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=p1MrETxd; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:To:From:Date:Sender:Reply-To:Cc:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=WHdbQnlfcOYTc10sxSqdjWKBT+rdFQUDsUt4B65OTok=; b=p1MrETxdo6Glkfbn+2vVS2RuEW
	rinH2/GnYT9ViW/GlytDBwgUUtTmnis3fU16E3YJmEwQC9ppSayw//xMK1gh+p4YTgQjTMFqJHEq9
	EGHfRR1+FVVXnJBKnyD5CGzrLHZzFN8poH8dC8IOvgs/LoXfchH+F3fORvbr2AItKgENhoT9g8Dau
	OTvOqDvrbmYPADRsOV309CtAb8CVNuHcxv5itsGIy4yAQHEKYP1h/QtwFTlQOcl48BVWZwdRfhtWM
	5j+LF4wnMJO5aqsNE4p3awTDT0ZraCyFA+kgCejP6UdgG9Dot1X7WSItWQtst1GF1lj+UpLVZen1r
	2VWNAtIw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1reYoF-00000000Gzk-46br;
	Mon, 26 Feb 2024 11:06:11 +0000
Date: Mon, 26 Feb 2024 03:06:11 -0800
From: Christoph Hellwig <hch@infradead.org>
To: Christoph Hellwig <hch@infradead.org>, Will Deacon <will@kernel.org>,
	Quentin Perret <qperret@google.com>,
	Chris Goldsworthy <quic_cgoldswo@quicinc.com>,
	Android KVM <android-kvm@google.com>,
	Patrick Daly <quic_pdaly@quicinc.com>,
	Alex Elder <elder@linaro.org>,
	Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
	Murali Nalajal <quic_mnalajal@quicinc.com>,
	Trilok Soni <quic_tsoni@quicinc.com>,
	Srivatsa Vaddagiri <quic_svaddagi@quicinc.com>,
	Carl van Schaik <quic_cvanscha@quicinc.com>,
	Philip Derrin <quic_pderrin@quicinc.com>,
	Prakruthi Deepak Heragu <quic_pheragu@quicinc.com>,
	Jonathan Corbet <corbet@lwn.net>, Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
	Fuad Tabba <tabba@google.com>,
	Sean Christopherson <seanjc@google.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-arm-msm@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-mm@kvack.org
Subject: Re: [PATCH v17 19/35] arch/mm: Export direct {un,}map functions
Message-ID: <Zdxwo0abvklfam-Z@infradead.org>
References: <20240222-gunyah-v17-0-1e9da6763d38@quicinc.com>
 <20240222-gunyah-v17-19-1e9da6763d38@quicinc.com>
 <ZdhEtH7xzbzdhS2j@infradead.org>
 <20240223071006483-0800.eberman@hu-eberman-lv.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240223071006483-0800.eberman@hu-eberman-lv.qualcomm.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

The point is that we can't we just allow modules to unmap data from
the kernel mapping, no matter how noble your intentions are.


