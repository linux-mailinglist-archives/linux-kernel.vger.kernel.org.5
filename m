Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A9B6480708B
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Dec 2023 14:09:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378408AbjLFNJa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Dec 2023 08:09:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378112AbjLFNJ2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Dec 2023 08:09:28 -0500
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com [67.231.149.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20589C7;
        Wed,  6 Dec 2023 05:09:35 -0800 (PST)
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
        by mx0a-001ae601.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 3B65uLUs028385;
        Wed, 6 Dec 2023 07:09:12 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=
        message-id:date:mime-version:subject:to:cc:references:from
        :in-reply-to:content-type:content-transfer-encoding; s=
        PODMain02222019; bh=vVXlRsiAy9OWWtQEMj4TkVdZXjoKPFJXcF0mguDSNPE=; b=
        Yb1qhaqwbcbNhueoO/dXJUufL4XWZiGxoWePc9h8BFt/xOiRDBaaNpor84WtKSfI
        wO3S0n6QSeZmAIBzSzWU2oiRlt4glnp+YrfANnGiAeNlwXrUOLBDme6MVfvZODJt
        vDvQJKYvzu50IEOPjhotO8mxXFX7sTUtp7/1r4T70dSLN+n9YOCPW0Pyr7SxXLs+
        CFbpaJlJg0cXWXpptd/hO6NQ1uf6UKuy4R5I8GAlxQT5DCN4UmhjluG63snJ/XbD
        yYCoeq4oalRUyO+cG5BTUBjdd9L9wbeWfOCFJ2FuXJciLJH3xtwxWg+EnLYCRkLW
        d/TYlQd1TPfCuJOSYGi17w==
Received: from ediex02.ad.cirrus.com ([84.19.233.68])
        by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 3utd47rphm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 06 Dec 2023 07:09:12 -0600 (CST)
Received: from ediex01.ad.cirrus.com (198.61.84.80) by ediex02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Wed, 6 Dec
 2023 13:09:10 +0000
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.2.1118.40 via Frontend
 Transport; Wed, 6 Dec 2023 13:09:10 +0000
Received: from [198.90.251.82] (edi-sw-dsktp-006.ad.cirrus.com [198.90.251.82])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id DA03711AB;
        Wed,  6 Dec 2023 13:09:09 +0000 (UTC)
Message-ID: <23e3e9b6-c6e2-4b89-b30e-0319f8789590@opensource.cirrus.com>
Date:   Wed, 6 Dec 2023 13:09:08 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] kunit: run test suites only after module
 initialization completes
To:     Marco Pagani <marpagan@redhat.com>,
        Brendan Higgins <brendan.higgins@linux.dev>,
        David Gow <davidgow@google.com>, Rae Moar <rmoar@google.com>,
        Jinjie Ruan <ruanjinjie@huawei.com>,
        Shuah Khan <skhan@linuxfoundation.org>
CC:     Javier Martinez Canillas <javierm@redhat.com>,
        <linux-kselftest@vger.kernel.org>, <kunit-dev@googlegroups.com>,
        <linux-kernel@vger.kernel.org>
References: <20231128101627.65399-1-marpagan@redhat.com>
Content-Language: en-US
From:   Richard Fitzgerald <rf@opensource.cirrus.com>
In-Reply-To: <20231128101627.65399-1-marpagan@redhat.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: y2rFDQWL8jBYyQGM-XoXdC0outj7skhz
X-Proofpoint-ORIG-GUID: y2rFDQWL8jBYyQGM-XoXdC0outj7skhz
X-Proofpoint-Spam-Reason: safe
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28/11/2023 10:16, Marco Pagani wrote:
> Commit 2810c1e99867 ("kunit: Fix wild-memory-access bug in
> kunit_free_suite_set()") fixed a wild-memory-access bug that could have
> happened during the loading phase of test suites built and executed as
> loadable modules. However, it also introduced a problematic side effect
> that causes test suites modules to crash when they attempt to register
> fake devices.
> 
> When a module is loaded, it traverses the MODULE_STATE_UNFORMED and
> MODULE_STATE_COMING states before reaching the normal operating state
> MODULE_STATE_LIVE. Finally, when the module is removed, it moves to
> MODULE_STATE_GOING before being released. However, if the loading
> function load_module() fails between complete_formation() and
> do_init_module(), the module goes directly from MODULE_STATE_COMING to
> MODULE_STATE_GOING without passing through MODULE_STATE_LIVE.
> 
> This behavior was causing kunit_module_exit() to be called without
> having first executed kunit_module_init(). Since kunit_module_exit() is
> responsible for freeing the memory allocated by kunit_module_init()
> through kunit_filter_suites(), this behavior was resulting in a
> wild-memory-access bug.
> 
> Commit 2810c1e99867 ("kunit: Fix wild-memory-access bug in
> kunit_free_suite_set()") fixed this issue by running the tests when the
> module is still in MODULE_STATE_COMING. However, modules in that state
> are not fully initialized, lacking sysfs kobjects. Therefore, if a test
> module attempts to register a fake device, it will inevitably crash.
> 
> This patch proposes a different approach to fix the original
> wild-memory-access bug while restoring the normal module execution flow
> by making kunit_module_exit() able to detect if kunit_module_init() has
> previously initialized the tests suite set. In this way, test modules
> can once again register fake devices without crashing.
> 
> This behavior is achieved by checking whether mod->kunit_suites is a
> virtual or direct mapping address. If it is a virtual address, then
> kunit_module_init() has allocated the suite_set in kunit_filter_suites()
> using kmalloc_array(). On the contrary, if mod->kunit_suites is still
> pointing to the original address that was set when looking up the
> .kunit_test_suites section of the module, then the loading phase has
> failed and there's no memory to be freed.
> 
> v2:
> - add include <linux/mm.h>
> 
> Fixes: 2810c1e99867 ("kunit: Fix wild-memory-access bug in kunit_free_suite_set()")
> Signed-off-by: Marco Pagani <marpagan@redhat.com>

Tested-by: Richard Fitzgerald <rf@opensource.cirrus.com>

Fixed this crash:
https://lore.kernel.org/all/e239b94b-462a-41e5-9a4c-cd1ffd530d75@opensource.cirrus.com/

Also tested with sound/pci/hda/cirrus_scodec_test.c
