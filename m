Return-Path: <linux-kernel+bounces-52852-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C2E57849D6E
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 15:53:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 76F811F246D5
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 14:53:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CADC72C68D;
	Mon,  5 Feb 2024 14:53:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="SHgNnjeX"
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9057B2C1A3;
	Mon,  5 Feb 2024 14:53:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707144822; cv=none; b=oSQaCsM8i7msJEmN7frSc28C3rJWIp49347jAECRCU+nkKLudMMTD2zMah1BPuLuh1l+fhDgVU87v8u+/2iEY1oKKBJi6Z3zhIH2dYZDKVrbeoClgXjDHj88GgL+FsZbzIQ4EyNwjLDpFtQL8HVoH7ZK2NgxC3T+k0FDR69mrPA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707144822; c=relaxed/simple;
	bh=zgpSFwK/RuwGGy5nVpnXOmOY1luA9tmV9Sa56nu68Qk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lZvDOw8SgKvbCxVIT87u7omPGd7ifpm5zVWhaCzPl+KICchFLUUG7k9gC0sW2JMymitICwsZH4j6K30VjXXmKna6WEqc4fdlT+4vsD1Es5Ki7buRgYBRO4KtCgsF/1nsKHjO3Aqji1fJZlAUqxDgwsfeHctniIFkin95JKti9Kk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=SHgNnjeX; arc=none smtp.client-ip=198.47.19.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
	by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 415ErZXw040445;
	Mon, 5 Feb 2024 08:53:35 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1707144815;
	bh=iQWZt/Ot+TCDcfpUSVkJkwXcIYFRT+fIClbuLsFtdmk=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=SHgNnjeXlUfXIqbr+p07vqF3Hp3XQtt79mNdlufllpHXqstzK8kr3onEr7wEMfmkd
	 niqV/4sHcMd0HTTerqqcguKtZDw04XtAdXmzBcgx2JMBOhv3XMtk6n9+Tlul7SN9EV
	 QuCC+5YO4CEe4+ETh7NmAZ25GgIxKULTrIrH21pc=
Received: from DFLE103.ent.ti.com (dfle103.ent.ti.com [10.64.6.24])
	by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 415ErZSD013928
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 5 Feb 2024 08:53:35 -0600
Received: from DFLE103.ent.ti.com (10.64.6.24) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 5
 Feb 2024 08:53:34 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 5 Feb 2024 08:53:34 -0600
Received: from localhost (uda0133052.dhcp.ti.com [128.247.81.232])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 415ErYDj124710;
	Mon, 5 Feb 2024 08:53:34 -0600
From: Nishanth Menon <nm@ti.com>
To: Conor Dooley <conor+dt@kernel.org>,
        Krzysztof Kozlowski
	<krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Santosh Shilimkar <ssantosh@kernel.org>, Nishanth Menon <nm@ti.com>
CC: <afd@ti.com>, <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH] ARM: dts: keystone: Replace http urls with https
Date: Mon, 5 Feb 2024 08:53:32 -0600
Message-ID: <170714480140.2498423.7719139696153373286.b4-ty@ti.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240109195612.3833281-1-nm@ti.com>
References: <20240109195612.3833281-1-nm@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

Hi Nishanth Menon,

On Tue, 09 Jan 2024 13:56:12 -0600, Nishanth Menon wrote:
> Replace http url instances with https.
> 
> 

I have applied the following to branch ti-keystone-dts-next on [1].
Thank you!

[1/1] ARM: dts: keystone: Replace http urls with https
      commit: 11621bedc016578e0b025b6f23458e9fe3f3caad

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent up the chain during
the next merge window (or sooner if it is a relevant bug fix), however if
problems are discovered then the patch may be dropped or reverted.

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

[1] https://git.kernel.org/pub/scm/linux/kernel/git/ti/linux.git
-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D


