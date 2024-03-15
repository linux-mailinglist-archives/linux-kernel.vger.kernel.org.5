Return-Path: <linux-kernel+bounces-104643-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E03AC87D15E
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 17:46:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4FB59282AA8
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 16:46:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C747246B91;
	Fri, 15 Mar 2024 16:44:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="j2KMhHEF"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75EB551026;
	Fri, 15 Mar 2024 16:44:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710521094; cv=none; b=Zt8dQns23ikW7zfYSlqP4rM6583uH72+F05v9LQdrNzyGRFvYxfIHTz1SM9UqlUMYEvLJH7b4xxFXo3iQ6XzmS4p/ReTj+jtJMkZFSwY1WrJqHSuPdm3CifVkzKTaPE8Dax2cromkbDJiTYGY8i0HahjX1CfskUSROKvH1GSCPE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710521094; c=relaxed/simple;
	bh=Xx1qfOfWLMhtqBj/0yAO1Fv9taKtjQ5VcXCBnfIF3hw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MyS09+rbvQqkqYabQs5o48DxlmV8h7ZXXOuxEYaxp0rmYmX+9lJiTbrlHExIftuh/GSGEgt1XJ603XxkjyTaxBn4MMtVlh0sf6LIH7FhBN15v6q9YwLybebKqqqYVQ+riM9Npcmu+DEl4I2OjXaaveXROMVaCMre1UDlhrSrtXY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=j2KMhHEF; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1710521092; x=1742057092;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Xx1qfOfWLMhtqBj/0yAO1Fv9taKtjQ5VcXCBnfIF3hw=;
  b=j2KMhHEFZul5cuzo+xM3LHHY1BinJPu5hJr1xFjurP212iHYkSU5ooCY
   Y+bsaiVIdBzYdyhPOM4mfQnh10Sra1xUVHlQn+ndAuFE1ID9yKABUV0/g
   3dRNFpvpP0Z0yG/Xnzmvxq0YQmmJtwmFXJuu/WNPQkQ8+6iw5Uw9m2ZlP
   K6OU3QXoyMuCL7Qkp/+v/s12BqpGmIMXMBqzFAbLc2dKRZo9TVC3BpqnE
   IYNYY75WtADUU5gFt29CQ2LViSnkFLCvXnb5ucHUrlfuchNsbrBZwwhfn
   s2ao6n3IERPGt6OZU7Qc5tvRsRGzn0an0c8FbZyR5f1htBG0w+OrynK89
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,11014"; a="5586411"
X-IronPort-AV: E=Sophos;i="6.07,128,1708416000"; 
   d="scan'208";a="5586411"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Mar 2024 09:44:51 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,128,1708416000"; 
   d="scan'208";a="12646946"
Received: from tassilo.jf.intel.com (HELO tassilo) ([10.54.38.190])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Mar 2024 09:44:48 -0700
Date: Fri, 15 Mar 2024 09:44:47 -0700
From: Andi Kleen <ak@linux.intel.com>
To: Adrian Hunter <adrian.hunter@intel.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>,
	Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
	Ian Rogers <irogers@google.com>, linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org
Subject: Re: [PATCH 1/2] perf script: Show also errors for --insn-trace option
Message-ID: <ZfR6_5JrSuCSJmPR@tassilo>
References: <20240315071334.3478-1-adrian.hunter@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240315071334.3478-1-adrian.hunter@intel.com>


Reviewed-by: Andi Kleen <ak@linux.intel.com>

