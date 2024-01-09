Return-Path: <linux-kernel+bounces-21281-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CCEA4828CFC
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 19:59:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6D957B23744
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 18:59:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE2D53D0BE;
	Tue,  9 Jan 2024 18:58:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JLeFMio1"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 460C03D0C1;
	Tue,  9 Jan 2024 18:58:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17844C433C7;
	Tue,  9 Jan 2024 18:58:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704826735;
	bh=frfr5IByY3xaoXjECp9aAtO5yrxIgIIlmCNFAnOInu4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=JLeFMio1dJrGEX1lBBiFoHih9IMPB8mkdccKZ3eUoMDl3wxKrJS6RToLFVg/UwsdV
	 7LakXLre2b8orTtp8vkKxFzoLB4n/MVwusnJAr8u/dYVydvf/n1HAon7PHcQ0izb6L
	 K20DaHQLDdQc9oj7CkJPnbymd2YmRWPG/stjOTNNL1FKAz25bikpkcoFUfbZ6+C1oL
	 NifGSOn/74nHqTICrMNyGjQWyP49iwfVv4eYfZ7l/08XB1h8S2qxhvO2VCxbbvvb2R
	 KbBV4s+s/RYZOEmPDv5q5ZNvDGcxXViRB47g29sfQfUjRwJZVCJ1n0SmPdFwJGEsE8
	 vYowMLNwb/V/A==
Received: (nullmailer pid 2946953 invoked by uid 1000);
	Tue, 09 Jan 2024 18:58:53 -0000
Date: Tue, 9 Jan 2024 12:58:53 -0600
From: Rob Herring <robh@kernel.org>
To: "Christian A. Ehrhardt" <lk@c--e.de>
Cc: Rob Herring <robh+dt@kernel.org>, linux-kernel@vger.kernel.org, Frank Rowand <frowand.list@gmail.com>, devicetree@vger.kernel.org, Stephen Boyd <stephen.boyd@linaro.org>
Subject: Re: [PATCH] of: Fix double free in of_parse_phandle_with_args_map
Message-ID: <170482604952.2932213.7130104450063134715.robh@kernel.org>
References: <20231229105411.1603434-1-lk@c--e.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231229105411.1603434-1-lk@c--e.de>


On Fri, 29 Dec 2023 11:54:11 +0100, Christian A. Ehrhardt wrote:
> In of_parse_phandle_with_args_map() the inner loop that
> iterates through the map entries calls of_node_put(new)
> to free the reference acquired by the previous iteration
> of the inner loop. This assumes that the value of "new" is
> NULL on the first iteration of the inner loop.
> 
> Make sure that this is true in all iterations of the outer
> loop by setting "new" to NULL after its value is assigned to "cur".
> 
> Extend the unittest to detect the double free and add an additional
> test case that actually triggers this path.
> 
> Fixes: bd6f2fd5a1 ("of: Support parsing phandle argument lists through a nexus node")
> Cc: Stephen Boyd <stephen.boyd@linaro.org>
> Signed-off-by: Christian A. Ehrhardt <lk@c--e.de>
> ---
>  drivers/of/base.c                           |  1 +
>  drivers/of/unittest-data/tests-phandle.dtsi | 10 ++-
>  drivers/of/unittest.c                       | 74 ++++++++++++---------
>  3 files changed, 53 insertions(+), 32 deletions(-)
> 

Applied, thanks!


