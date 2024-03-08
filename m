Return-Path: <linux-kernel+bounces-96797-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 71C0D876191
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 11:10:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 275D01F232B9
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 10:10:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F117D54FA8;
	Fri,  8 Mar 2024 10:09:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f3Uphj2T"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 396015381E;
	Fri,  8 Mar 2024 10:09:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709892597; cv=none; b=b6poUQkiesOaJxcz+QFqHmGfLhG/vMuhglIgrj+3N24ANHZV2MVcdGarNKllCGG8t20sT8nYHvD8PmH/BmkEHn1/U+ZfcySRl5uwAMvwuCF3UxA/IBIq2Ls8cDl+5uYo0MLQWu6068s1yUn2PUGSgjX746OzRdcctBAwPAQ+uUY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709892597; c=relaxed/simple;
	bh=rI1oFIFEK1FcWmr4toRcEN4YoV5f3o2/ZWrSKqQ+k1A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ocz7r3uCZl17v+Qm2CZ3Lc9ya/7YZ0p/rCRVWatwiTX0RIqD2H+8WQNIHVp0+9whnGCCohi7R31ZdCD294dNmHu+YRE2sTaFOzvQSMa2pc5hTdOzQSPrdoNcqJIaJKb+vPXZdk+AYX0OUaCqnwUJwpCESRSPZLooCj8irdOCUzw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f3Uphj2T; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 94C93C43394;
	Fri,  8 Mar 2024 10:09:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709892596;
	bh=rI1oFIFEK1FcWmr4toRcEN4YoV5f3o2/ZWrSKqQ+k1A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=f3Uphj2T+qfSXuqP1faGyiiiMXqmDxdhEMjbvjZ5sRNqTqQH+5IbXgc+8oa2UeLkr
	 dCisi43O9Qyvo1v8lAst+FylMVSlnZj39JQiLucE1H7yK2IpJL5KXXds/XbdxwkO1j
	 2ujnYfHDxmDlNg/Kk8pnQjxunlQz4nTqpsCwAwDQlM4G0e9miG5nL7320w6Ho8Z/FM
	 H/goKrGY1jPFnWR8PNIfC/tEb0t7oX6DFc67YWiuWRgiBd3l820RX88T3Pn3/EMmn7
	 DcMxIpoTI2xJw6pGRb6T+j70zLK9B6V9ByAMqbqN5V1IRjh7S/LR8sZUgZu99nMrpK
	 TG/I3BrYADa2A==
Date: Fri, 8 Mar 2024 11:09:50 +0100
From: Niklas Cassel <cassel@kernel.org>
To: Igor Pylypiv <ipylypiv@google.com>
Cc: Damien Le Moal <dlemoal@kernel.org>,
	John Garry <john.g.garry@oracle.com>,
	Jason Yan <yanaijie@huawei.com>,
	"James E.J. Bottomley" <jejb@linux.ibm.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Jack Wang <jinpu.wang@cloud.ionos.com>,
	Hannes Reinecke <hare@suse.de>,
	Xiang Chen <chenxiang66@hisilicon.com>,
	Artur Paszkiewicz <artur.paszkiewicz@intel.com>,
	Bart Van Assche <bvanassche@acm.org>,
	TJ Adams <tadamsjr@google.com>, linux-ide@vger.kernel.org,
	linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v8 5/7] scsi: hisi_sas: Add libsas SATA sysfs attributes
 group
Message-ID: <Zerj7sNjglE1V_MV@ryzen>
References: <20240307214418.3812290-1-ipylypiv@google.com>
 <20240307214418.3812290-6-ipylypiv@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240307214418.3812290-6-ipylypiv@google.com>

On Thu, Mar 07, 2024 at 01:44:16PM -0800, Igor Pylypiv wrote:
> The added sysfs attributes group enables the configuration of NCQ Priority
> feature for HBAs that rely on libsas to manage SATA devices.
> 
> Omitted hisi_sas_v1_hw.c because v1 HW doesn't support SATA.
> 
> Reviewed-by: John Garry <john.g.garry@oracle.com>
> Reviewed-by: Damien Le Moal <dlemoal@kernel.org>
> Reviewed-by: Jason Yan <yanaijie@huawei.com>
> Reviewed-by: Hannes Reinecke <hare@suse.de>
> Signed-off-by: Igor Pylypiv <ipylypiv@google.com>
> ---

Reviewed-by: Niklas Cassel <cassel@kernel.org>

