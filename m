Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 992AE78E1A7
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Aug 2023 23:53:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242869AbjH3Vw7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Aug 2023 17:52:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242870AbjH3Vw5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Aug 2023 17:52:57 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6691FCD7
        for <linux-kernel@vger.kernel.org>; Wed, 30 Aug 2023 14:52:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id F1CEC61482
        for <linux-kernel@vger.kernel.org>; Wed, 30 Aug 2023 20:45:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D46FEC433C7;
        Wed, 30 Aug 2023 20:45:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1693428355;
        bh=TqT9Cfnwh+ygT7+Q36jzRz6qPPhxjFw4O+Y4jAuDhY4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=W3DzMfdkwsUo7rS3Py9nPQPIMP4TmsOeS9JfFgHlUxMFHPK1t+zdZdoeklydPnbRM
         Eu3KuNS0QkC2zfvvZOlsPBOun1q/lLVrGTQOPnetsemi2nf4Lvl2869QtfpBRW4Esi
         FBqyyKH4T/41WGAdBbqEmOQXW+/N7+RAfxOPiu8U=
Date:   Wed, 30 Aug 2023 22:45:52 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     linux-coco@lists.linux.dev,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Dionna Amalie Glaze <dionnaglaze@google.com>,
        James Bottomley <James.Bottomley@hansenpartnership.com>,
        Peter Gonda <pgonda@google.com>,
        Samuel Ortiz <sameo@rivosinc.com>, peterz@infradead.org,
        linux-kernel@vger.kernel.org, tglx@linutronix.de
Subject: Re: [PATCH v3 2/5] configfs-tsm: Introduce a shared ABI for
 attestation reports
Message-ID: <2023083029-wackiness-lilac-39dd@gregkh>
References: <169342399185.3934343.3035845348326944519.stgit@dwillia2-xfh.jf.intel.com>
 <169342400469.3934343.12316161608372095860.stgit@dwillia2-xfh.jf.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <169342400469.3934343.12316161608372095860.stgit@dwillia2-xfh.jf.intel.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 30, 2023 at 12:33:24PM -0700, Dan Williams wrote:
> One of the common operations of a TSM (Trusted Security Module) is to
> provide a way for a TVM (confidential computing guest execution
> environment) to take a measurement of its launch state, sign it and
> submit it to a verifying party. Upon successful attestation that
> verifies the integrity of the TVM additional secrets may be deployed.
> The concept is common across TSMs, but the implementations are
> unfortunately vendor specific. While the industry grapples with a common
> definition of this attestation format [1], Linux need not make this
> problem worse by defining a new ABI per TSM that wants to perform a
> similar operation. The current momentum has been to invent new ioctl-ABI
> per TSM per function which at best is an abdication of the kernel's
> responsibility to make common infrastructure concepts share common ABI.
> 
> The proposal, targeted to conceptually work with TDX, SEV-SNP, COVE if
> not more, is to define a configfs interface to retrieve the TSM-specific
> blob.
> 
>     report=/sys/kernel/config/tsm/report/report0
>     mkdir $report
>     dd if=binary_userdata_plus_nonce > $report/inblob
>     hexdump $report/outblob
> 
> This approach later allows for the standardization of the attestation
> blob format without needing to invent a new ABI. Once standardization
> happens the standard format can be emitted by $report/outblob and
> indicated by $report/provider, or a new attribute like
> "$report/tcg_coco_report" can emit the standard format alongside the
> vendor format.
> 
> Review of previous iterations of this interface identified that there is
> a need to scale report generation for multiple container environments
> [2]. Configfs enables a model where each container can bind mount one or
> more report generation item instances. Still, within a container only a
> single thread can be manipulating a given configuration instance at a
> time. A 'generation' count is provided to detect conflicts between
> multiple threads racing to configure a report instance.
> 
> The SEV-SNP concepts of "extended reports" and "privilege levels" are
> optionally enabled by selecting 'tsm_report_ext_type' at register_tsm()
> time. The expectation is that those concepts are generic enough that
> they may be adopted by other TSM implementations. In other words,
> configfs-tsm aims to address a superset of TSM specific functionality
> with a common ABI where attributes may appear, or not appear, based on the set
> of concepts the implementation supports.
> 
> Link: http://lore.kernel.org/r/64961c3baf8ce_142af829436@dwillia2-xfh.jf.intel.com.notmuch [1]
> Link: http://lore.kernel.org/r/57f3a05e-8fcd-4656-beea-56bb8365ae64@linux.microsoft.com [2]
> Cc: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
> Cc: Dionna Amalie Glaze <dionnaglaze@google.com>
> Cc: James Bottomley <James.Bottomley@HansenPartnership.com>
> Cc: Peter Gonda <pgonda@google.com>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: Samuel Ortiz <sameo@rivosinc.com>
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> ---
>  Documentation/ABI/testing/configfs-tsm |   68 ++++++

Nice, I like the use of configfs here.

One very tiny naming nit, feel free to ignore if you don't want to
change it:

> +int register_tsm(const struct tsm_ops *ops, void *priv,
> +		 const struct config_item_type *type);
> +int unregister_tsm(const struct tsm_ops *ops);

Usually it's "noun_verb" for stuff that you export to the global
namespace these days.

So perhaps tsm_register() and tsm_unregister()?

Either way, it's your call:

Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
