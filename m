Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE4DA75243D
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jul 2023 15:53:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230370AbjGMNxJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jul 2023 09:53:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230055AbjGMNxF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jul 2023 09:53:05 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CD401BB;
        Thu, 13 Jul 2023 06:53:04 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A70A76153C;
        Thu, 13 Jul 2023 13:53:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3EC08C433C8;
        Thu, 13 Jul 2023 13:53:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1689256383;
        bh=w5LLgIZiA/btIJxLrU1uFBOOrNr8csz5UTI65mS9fq0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Mt/jU90KgCZ+fRV/Z6tu1bSY3p4Amf7wsK4qQwPlj2t2+F4Y/puWkPD+K1WweHZh2
         hhwWo2HgFZwd7Usob9eVzCCuh1B1CBJzjDmo0rOxhhgMxNvuCCcQGm3uGw+2sEbvUQ
         wHMhwMzn2RIho40hg6LdEGAm9dUW1lvVXLeCwyQw=
Date:   Thu, 13 Jul 2023 15:52:58 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Souradeep Chowdhury <quic_schowdhu@quicinc.com>
Cc:     linux-arm-msm@vger.kernel.org, linux-usb@vger.kernel.org,
        Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Bjorn Andersson <andersson@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Sibi Sankar <quic_sibis@quicinc.com>,
        Rajendra Nayak <quic_rjendra@quicinc.com>
Subject: Re: [PATCH V1 0/3] Add notifier call chain to Embedded USB
 Debug(EUD) driver
Message-ID: <2023071328-siamese-brethren-0174@gregkh>
References: <cover.1689148711.git.quic_schowdhu@quicinc.com>
 <2023071218-woven-oversleep-444f@gregkh>
 <d8987058-ee49-cdbd-0fc1-ed80829473b5@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d8987058-ee49-cdbd-0fc1-ed80829473b5@quicinc.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 13, 2023 at 01:55:34PM +0530, Souradeep Chowdhury wrote:
> 
> 
> On 7/12/2023 10:10 PM, Greg KH wrote:
> > On Wed, Jul 12, 2023 at 01:52:37PM +0530, Souradeep Chowdhury wrote:
> > > This patch series adds the notifier chain to the Embedded USB Debug(EUD) driver.
> > > The notifier chain is used to check the role switch status of EUD. Since EUD can
> > > function only in device mode, other modules trying to do role-switch on the same
> > > port have to first check the EUD status by calling this notifier chain and based
> > > on the status proceed or block their role-switching step. The modules can call
> > > the notifier through the call eud_notifier_call_chain and pass their own
> > > role switch state as the argument. This chain will also be able to handle the
> > > scenario of multiple modules switching roles on the same port since this can
> > > create a priority and ordering among them for conflict resolution.
> > 
> > You are adding a new api that no one is actually using, so why would we
> > accept this at all?
> > 
> > And how can we actually review it without any real users?
> 
> Ack. The next version of this will be posted along with the usage
> of these apis for ordering the role-switch.

Also note that I hate notifier call chains, so you better have a very
good reason for why they are required and can't be done in any other
normal way instead :)

good luck!

greg k-h
