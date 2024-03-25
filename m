Return-Path: <linux-kernel+bounces-117807-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5299488AFC4
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 20:23:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 83EA91C374AF
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 19:23:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5C30182A0;
	Mon, 25 Mar 2024 19:23:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hpe.com header.i=@hpe.com header.b="f1Vj+EL7"
Received: from mx0b-002e3701.pphosted.com (mx0b-002e3701.pphosted.com [148.163.143.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3186E182DF;
	Mon, 25 Mar 2024 19:23:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.143.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711394589; cv=none; b=CanTKA68IJ/Hf5FUufR5gWUHLvnGvVy6ZTKL2wFw1ivP9mQ0B74XB79aqOsczvdFkIncxfEdFzH9MyHG5h9YlhDv0ieFn08UdoQSr2VSBw9QTnvV1w4u6YU3w/6UKMeZERE8HNCAnaEzFaAO0kzNl+mfMaVTDIjJr36omD+nRI0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711394589; c=relaxed/simple;
	bh=7culdjHPWtO4rCw2JPlSW0eveazDTAT80DhwvtzRH7g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=du6/AtN0GekhhgADQxVcwTUzT6waBW/te204i2i2tNRyNDWmJ+PEZclme/Wgo12vXp/1BGbL9orzHOqhxzx8OVrg+8zGRYTj/Cu94LoFE5iu67kF3XMX0n210MNej16ElepIzLrQui2pCAOihv4IOrlYNqshtCdwtfmFLpWaYFM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hpe.com; spf=pass smtp.mailfrom=hpe.com; dkim=pass (2048-bit key) header.d=hpe.com header.i=@hpe.com header.b=f1Vj+EL7; arc=none smtp.client-ip=148.163.143.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hpe.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hpe.com
Received: from pps.filterd (m0134424.ppops.net [127.0.0.1])
	by mx0b-002e3701.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 42PJ2els018274;
	Mon, 25 Mar 2024 19:22:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pps0720; bh=DhYi/4Kwoqd+aMH4bZbT7Tk7UOmwG8WruxUswzwA/zs=;
 b=f1Vj+EL7+PjrC+2oI0sZ+K3dIjFcfb+VAd0qB0Cf0nbk2t5EySN2/OGPUON9w8+VgvbH
 ajCzVABPj6rIR0B+CY9WxVkVpgLkxTiulCUrlgMYT1vpXdr7SWjI117BMGihoYfodPuN
 tsPMWr0rdPN/hYfXf+5mYq9E6buZ0R6AQioOX7ldBYd6IX0tNTZB7z2O3FeEtfm9T5EZ
 WUG3y/TYTBHV34p0cwX0Exj1xIcrjSgEU2zVsZov6iRZkEpoXws4/qITfDdf6J3SYHkx
 UeAt/tEaWH16Vznh2QDdTemH6vGnz6HUzoDzJ4ppq8VfO90aofAdds6GIsYua5ALruWa 1w== 
Received: from p1lg14881.it.hpe.com ([16.230.97.202])
	by mx0b-002e3701.pphosted.com (PPS) with ESMTPS id 3x37c4vg5w-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 25 Mar 2024 19:22:32 +0000
Received: from p1lg14886.dc01.its.hpecorp.net (unknown [10.119.18.237])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by p1lg14881.it.hpe.com (Postfix) with ESMTPS id AA769805EB9;
	Mon, 25 Mar 2024 19:22:31 +0000 (UTC)
Received: from swahl-home.5wahls.com (unknown [16.231.227.36])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(Client did not present a certificate)
	by p1lg14886.dc01.its.hpecorp.net (Postfix) with ESMTPS id 3AF18808E91;
	Mon, 25 Mar 2024 19:22:27 +0000 (UTC)
Date: Mon, 25 Mar 2024 14:22:25 -0500
From: Steve Wahl <steve.wahl@hpe.com>
To: Ingo Molnar <mingo@kernel.org>
Cc: Steve Wahl <steve.wahl@hpe.com>, Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
        Borislav Petkov <bp@alien8.de>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org,
        Linux regressions mailing list <regressions@lists.linux.dev>,
        Pavin Joseph <me@pavinjoseph.com>, stable@vger.kernel.org,
        Eric Hagberg <ehagberg@gmail.com>, Simon Horman <horms@verge.net.au>,
        Eric Biederman <ebiederm@xmission.com>, Dave Young <dyoung@redhat.com>,
        Sarah Brofeldt <srhb@dbc.dk>, Russ Anderson <rja@hpe.com>,
        Dimitri Sivanich <sivanich@hpe.com>
Subject: Re: [PATCH] x86/mm/ident_map: Use full gbpages in identity maps
 except on UV platform.
Message-ID: <ZgHO8T_dfrzPBTaZ@swahl-home.5wahls.com>
References: <20240322162135.3984233-1-steve.wahl@hpe.com>
 <ZgABC1oQ9YJW6Bw3@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZgABC1oQ9YJW6Bw3@gmail.com>
X-Proofpoint-ORIG-GUID: EJ20KfSpLGvNUN8sK5aTGqJOTVRgmrYW
X-Proofpoint-GUID: EJ20KfSpLGvNUN8sK5aTGqJOTVRgmrYW
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-25_18,2024-03-21_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999
 impostorscore=0 suspectscore=0 mlxscore=0 malwarescore=0
 priorityscore=1501 phishscore=0 clxscore=1011 lowpriorityscore=0
 spamscore=0 adultscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2403210000 definitions=main-2403250116

On Sun, Mar 24, 2024 at 11:31:39AM +0100, Ingo Molnar wrote:
> 
> * Steve Wahl <steve.wahl@hpe.com> wrote:
> 
> > Some systems have ACPI tables that don't include everything that needs
> > to be mapped for a successful kexec.  These systems rely on identity
> > maps that include the full gigabyte surrounding any smaller region
> > requested for kexec success.  Without this, they fail to kexec and end
> > up doing a full firmware reboot.
> > 
> > So, reduce the use of GB pages only on systems where this is known to
> > be necessary (specifically, UV systems).
> > 
> > Signed-off-by: Steve Wahl <steve.wahl@hpe.com>
> > Fixes: d794734c9bbf ("x86/mm/ident_map: Use gbpages only where full GB page should be mapped.")
> > Reported-by: Pavin Joseph <me@pavinjoseph.com>
> 
> Sigh, why was d794734c9bbf marked for a -stable backport? The commit 
> never explains ...
> 
> If it's broken, it should be reverted - instead of trying to partially 
> revert and then maybe break some other systems.
> 
> When there's boot breakage with new patches, we back out the bad patch 
> and re-try in 99.9% of the cases.

Fine with me, especially as you've already done the revert. :-)

I will create a new patch that combines the two.  If you have any
specific actions you'd like to be sure I do for this, let me know.

Thanks,

--> Steve Wahl
-- 
Steve Wahl, Hewlett Packard Enterprise

