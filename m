Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E664F78FA7B
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Sep 2023 11:10:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348726AbjIAJKL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Sep 2023 05:10:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231508AbjIAJKK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Sep 2023 05:10:10 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3992C91;
        Fri,  1 Sep 2023 02:10:07 -0700 (PDT)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.200])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4RcXJm4g6wz6HJgt;
        Fri,  1 Sep 2023 17:08:56 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.31; Fri, 1 Sep
 2023 10:10:04 +0100
Date:   Fri, 1 Sep 2023 10:10:03 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Dan Williams <dan.j.williams@intel.com>
CC:     Terry Bowman <terry.bowman@amd.com>, <alison.schofield@intel.com>,
        <vishal.l.verma@intel.com>, <ira.weiny@intel.com>,
        <bwidawsk@kernel.org>, <dave.jiang@intel.com>,
        <linux-cxl@vger.kernel.org>, <rrichter@amd.com>,
        <linux-kernel@vger.kernel.org>, <bhelgaas@google.com>
Subject: Re: [PATCH v9 02/15] cxl/regs: Prepare for multiple users of
 register mappings
Message-ID: <20230901101003.000074f1@Huawei.com>
In-Reply-To: <64f0d7dbf05f6_31c2db2948e@dwillia2-xfh.jf.intel.com.notmuch>
References: <20230825233211.3029825-1-terry.bowman@amd.com>
        <20230825233211.3029825-3-terry.bowman@amd.com>
        <64f0d7dbf05f6_31c2db2948e@dwillia2-xfh.jf.intel.com.notmuch>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.227.76]
X-ClientProxiedBy: lhrpeml500006.china.huawei.com (7.191.161.198) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 31 Aug 2023 11:11:40 -0700
Dan Williams <dan.j.williams@intel.com> wrote:

> Terry Bowman wrote:
> > From: Robert Richter <rrichter@amd.com>
> > 
> > The function devm_cxl_iomap_block() is used to map register mappings
> > of CXL component or device registers. A @dev is used to unmap the IO
> > regions during device removal.
> > 
> > Now, there are multiple devices using the register mappings. E.g. the
> > RAS cap of the Component Registers is used by cxl_pci, the HDM cap
> > used in cxl_mem. This could cause IO blocks not being freed and a
> > subsequent reinitialization to fail if the same device is used for
> > both.
> > 
> > To prevent that, expand cxl_map_component_regs() to pass a @dev to be
> > used with devm to IO unmap. This allows to pass the device that
> > actually is creating and using the IO region.
> > 
> > For symmetry also change the function i/f of cxl_map_device_regs().  
> 
> I think @dev is too ambiguous as a name. I.e. when does @dev refer to
> the 'struct device *' instance that the registers belong, and when does
> @dev refer to the 'struct device *' instance hosting the mapping for
> devm operations?
> 
> One of the ways I have tried to disambiguate that distinction is using
> the name @host to explicitly refer to the context of devm operations,
> and @dev is only for context for dev_dbg() operations. Can you clarify
> this patch by using @host everywhere that the devm context is being
> handled?
> 
> This would also satisfy Jonathan's concern. I think it needs to be the
> case that @map is explicit about when it is conveying some @dev context for
> dev_dbg() messages and when it is conveying the @host for devm
> operations because those are 2 different concepts.

I should read all the replies before I reply to any of them.
Agreed that renaming it would satisfy my concern over the confusion.

> 
> It looks like @dev argument you are plumbing here is for when @map->dev
> cannot be used for devm operations, so at a minimum use @host as the
> variable name to make that clear...
> 
> ...or always make it the case that @map carries an @host parameter which
> would mean that ports would need their own copy of the comp_map versus
> directly reusing the one in the cxlds since those 2 mapping instances
> need different @host parameters. That feels cleaner to me then
> "sometimes map->dev can be used for devm and sometimes not". @map->host
> is always the devm context.

Agreed that may be better still.

Jonathan


