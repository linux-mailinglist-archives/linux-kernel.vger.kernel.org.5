Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD4F6803901
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Dec 2023 16:39:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234760AbjLDPjN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 10:39:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234728AbjLDPjK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 10:39:10 -0500
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4578FFD;
        Mon,  4 Dec 2023 07:39:16 -0800 (PST)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 59D36227A8E; Mon,  4 Dec 2023 16:39:12 +0100 (CET)
Date:   Mon, 4 Dec 2023 16:39:12 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     John Garry <john.g.garry@oracle.com>
Cc:     Christoph Hellwig <hch@lst.de>, axboe@kernel.dk, kbusch@kernel.org,
        sagi@grimberg.me, jejb@linux.ibm.com, martin.petersen@oracle.com,
        djwong@kernel.org, viro@zeniv.linux.org.uk, brauner@kernel.org,
        chandan.babu@oracle.com, dchinner@redhat.com,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-nvme@lists.infradead.org, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, tytso@mit.edu, jbongio@google.com,
        linux-api@vger.kernel.org
Subject: Re: [PATCH 17/21] fs: xfs: iomap atomic write support
Message-ID: <20231204153912.GA3580@lst.de>
References: <20230929102726.2985188-1-john.g.garry@oracle.com> <20230929102726.2985188-18-john.g.garry@oracle.com> <20231109152615.GB1521@lst.de> <a50a16ca-d4b9-a4d8-4230-833d82752bd2@oracle.com> <c78bcca7-8f09-41c7-adf0-03b42cde70d6@oracle.com> <20231128135619.GA12202@lst.de> <e4fb6875-e552-45aa-b193-58f15d9a786c@oracle.com> <20231204134509.GA25834@lst.de> <a87d48a7-f2a8-40ae-8d9b-e4534ccc29b1@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a87d48a7-f2a8-40ae-8d9b-e4534ccc29b1@oracle.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 04, 2023 at 03:19:15PM +0000, John Garry wrote:
> On 04/12/2023 13:45, Christoph Hellwig wrote:
>> On Tue, Nov 28, 2023 at 05:42:10PM +0000, John Garry wrote:
>>> ok, fine, it would not be required for XFS with CoW. Some concerns still:
>>> a. device atomic write boundary, if any
>>> b. other FSes which do not have CoW support. ext4 is already being used for
>>> "atomic writes" in the field - see dubious amazon torn-write prevention.
>>
>> What is the 'dubious amazon torn-write prevention'?
>
> https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/storage-twp.html
>
> AFAICS, this is without any kernel changes, so no guarantee of unwanted 
> splitting or merging of bios.
>
> Anyway, there will still be !CoW FSes which people want to support.

Ugg, so they badly reimplement NVMe atomic write support and use it
without software stack enablement.  Calling it dubious is way to
gentle..

>> Relying just on the hardware seems very limited, especially as there is
>> plenty of hardware that won't guarantee anything larger than 4k, and
>> plenty of NVMe hardware without has some other small limit like 32k
>> because it doesn't support multiple atomicy mode.
>
> So what would you propose as the next step? Would it to be first achieve 
> atomic write support for XFS with HW support + CoW to ensure contiguous 
> extents (and without XFS forcealign)?

I think the very first priority is just block device support without
any fs enablement.  We just need to make sure the API isn't too limited
for additional use cases.

> Ignoring FSes, then how is this supposed to work for block devices? We just 
> always need HW support, right?

Yes.
