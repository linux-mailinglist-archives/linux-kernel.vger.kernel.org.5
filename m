Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8FD2277637E
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Aug 2023 17:14:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233516AbjHIPOG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Aug 2023 11:14:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229636AbjHIPOF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Aug 2023 11:14:05 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5A63D1
        for <linux-kernel@vger.kernel.org>; Wed,  9 Aug 2023 08:14:04 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1691594042;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=B3sTTqWWsmwFizADQvhTeeO1rumuAfcsA6LtTSkD/Q0=;
        b=094M9fF6fSomx5tzy1KxSduSyJBCkBVrDD2dstrVRUE4ipHN/xvMBtEvkVTDrDz1yCLqEy
        1GPARuTXNqMF46MfqMJwBF5BIm3UF82gmNbvC/pdsM6ZsRkPJ3uJu6Hu+sSmoLfcsU/kj5
        9CLE+lIlaezSAln97GR5prwUyfhkJjD/ERC95/dHBNPdijZxfLKbEVn8Nbu2JXANVVG59p
        BOLizWtHylGg2+1VDF/xPvFRml//WRPXofhaFgJ4VYUEosE63/x35l9yoExqrchmMm88mK
        jWupuL0SAURnPNzODdtPNf68AP1bg3lFTUlc5HYFXz6wOFxQ7pQFqrFwJfFNjw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1691594042;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=B3sTTqWWsmwFizADQvhTeeO1rumuAfcsA6LtTSkD/Q0=;
        b=Diy1ew4OfmuJjHYBXsHc+HO9bpz0bNo7LOQHoO2YQsIzfX/UKlTG2tkiQwmAVVLt99rMFj
        9zFR1Qmi7DHncABA==
To:     "Zhang, Rui" <rui.zhang@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc:     "Gross, Jurgen" <jgross@suse.com>,
        "mikelley@microsoft.com" <mikelley@microsoft.com>,
        "arjan@linux.intel.com" <arjan@linux.intel.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "thomas.lendacky@amd.com" <thomas.lendacky@amd.com>,
        "ray.huang@amd.com" <ray.huang@amd.com>,
        "andrew.cooper3@citrix.com" <andrew.cooper3@citrix.com>,
        "Sivanich, Dimitri" <dimitri.sivanich@hpe.com>,
        "wei.liu@kernel.org" <wei.liu@kernel.org>
Subject: Re: [patch V3 05/40] x86/cpu: Move cpu_die_id into topology info
In-Reply-To: <94b826a0d260a4edcf0242b4c4d706bce5e6d0eb.camel@intel.com>
References: <20230802101635.459108805@linutronix.de>
 <20230802101932.991285236@linutronix.de>
 <94b826a0d260a4edcf0242b4c4d706bce5e6d0eb.camel@intel.com>
Date:   Wed, 09 Aug 2023 17:14:02 +0200
Message-ID: <87il9ojlj9.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 09 2023 at 14:32, Rui Zhang wrote:
>> @@ -55,7 +55,7 @@ AMD nomenclature for package is 'Node'.
>> =C2=A0
>> =C2=A0=C2=A0=C2=A0=C2=A0 The number of dies in a package. This informati=
on is retrieved
>> via CPUID.
>> =C2=A0
>> -=C2=A0 - cpuinfo_x86.cpu_die_id:
>> +=C2=A0 - cpuinfo_x86.topo_die_id:
>
> s/topo_die_id/topo.die_id

Ooops. I surely fixed that up later and forgot to fold back.
