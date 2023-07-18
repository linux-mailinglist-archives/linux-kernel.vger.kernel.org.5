Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7CFD757D38
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 15:20:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232676AbjGRNUx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jul 2023 09:20:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232304AbjGRNUo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 09:20:44 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 5BA83E3;
        Tue, 18 Jul 2023 06:20:33 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 434D22F4;
        Tue, 18 Jul 2023 06:21:16 -0700 (PDT)
Received: from bogus (e103737-lin.cambridge.arm.com [10.1.197.49])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6C86E3F6C4;
        Tue, 18 Jul 2023 06:20:31 -0700 (PDT)
Date:   Tue, 18 Jul 2023 14:20:28 +0100
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Cristian Marussi <cristian.marussi@arm.com>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-pm@vger.kernel.org, james.quinlan@broadcom.com,
        f.fainelli@gmail.com, vincent.guittot@linaro.org,
        lukasz.luba@arm.com, "Rafael J . Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH v2] powercap: arm_scmi: Remove recursion while parsing
 zones
Message-ID: <20230718132028.wtycky4amu35xxcy@bogus>
References: <20230718101726.1864761-1-cristian.marussi@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230718101726.1864761-1-cristian.marussi@arm.com>
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 18, 2023 at 11:17:26AM +0100, Cristian Marussi wrote:
> Powercap zones can be defined as arranged in a hierarchy of trees and when
> registering a zone with powercap_register_zone(), the kernel powercap
> subsystem expects this to happen starting from the root zones down to the
> leaves; on the other side, de-registration by powercap_deregister_zone()
> must begin from the leaf zones.
> 
> Available SCMI powercap zones are retrieved dynamically from the platform
> at probe time and, while any defined hierarchy between the zones is
> described properly in the zones descriptor, the platform returns the
> availables zones with no particular well-defined order: as a consequence,
> the trees possibly composing the hierarchy of zones have to be somehow
> walked properly to register the retrieved zones from the root.
> 
> Currently the ARM SCMI Powercap driver walks the zones using a recursive
> algorithm; this approach, even though correct and tested can lead to kernel
> stack overflow when processing a returned hierarchy of zones composed by
> particularly high trees.
> 
> Avoid possible kernel stack overflow by substituting the recursive approach
> with an iterative one supported by a dynamically allocated stack-like data
> structure.
> 
> Cc: Rafael J. Wysocki <rafael@kernel.org>
> Fixes: b55eef5226b7 ("powercap: arm_scmi: Add SCMI Powercap based driver")

Makes sense,

Acked-by: Sudeep Holla <sudeep.holla@arm.com>

--
Regards,
Sudeep
