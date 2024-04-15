Return-Path: <linux-kernel+bounces-146012-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 76AF48A5E9B
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 01:43:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A835C1C20C0C
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 23:43:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34380159206;
	Mon, 15 Apr 2024 23:43:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="tYlwGN1w"
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02F19156979
	for <linux-kernel@vger.kernel.org>; Mon, 15 Apr 2024 23:42:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713224581; cv=none; b=AzXnjvCQ/pqIucsTHCh0zzO6YbCGw1F6bGeTAiEBjoedAI5Y+9E9JeG2odgFfNISSREKuP7t8oYKr2qccgB7weCecPRKCJJJDV2s6xTlrhW3upv+/bm1qFtfisFk2ZOUI+U0f22fDzKzfw9PXdZeklSqMmbR8mm+/PxMgeb2XTs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713224581; c=relaxed/simple;
	bh=qAvuKuIMHvMMzJoIGDtMxc4BInAaG8Ef8b0hej1lKnM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aGHlL2SQHyRjAnFk+aBuTcX+lgRtL4SrV2XZnwZ2W4jWt4lg6Ic2yPgkd8M/VHhC6oosyc0Mlo7173R/UMkxbxVM9/uCpf3sPBIBEOM5JH5v1XimoQ7qmUmONb81Jhn0lWMTUB1nB2OIbotZiVHWHEhsnpXg0dE0ySzP/xKPh5A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=tYlwGN1w; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=O+8V4PbTK3XzyHAuVCcumPJViifcheuhcBT0xOgfKzc=; b=tYlwGN1wF+fEnZnUDk1b8k2yxr
	sKE1gyjMGmNZDY3cQ7pN+vDKymJkYB1V0OGHHIDrTm6gNNKmW6l9S0Mz5nj7JPolvVf+kCaR4VIL7
	nwvGcxb6t5CNmnYHrzPHL02giw0Oz2ilCsWnsNf/G7tKWNEayus7rbgZlhuJJOUT+49ZAp+nylbBg
	uxzLxQB/FwJx3DDRq8CExowc4AizsAUAqHJcrZsbdP88PN50H95rqVZe3PBPrr7pm7qBzPbJzCtJc
	5GbzUzxhsNABj2qlT4w7Slpnifl3rORTgWD5Wyz/8TcxUJGjjVotXaWDSkIR9S3ellcXDGVBOfGfw
	OS0013uw==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
	id 1rwVyT-00D5MJ-08;
	Mon, 15 Apr 2024 23:42:57 +0000
Date: Tue, 16 Apr 2024 00:42:57 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH 002/437] fs: add generic read/write iterator helpers
Message-ID: <20240415234257.GY2118490@ZenIV>
References: <20240411153126.16201-1-axboe@kernel.dk>
 <20240411153126.16201-3-axboe@kernel.dk>
 <20240415195504.GU2118490@ZenIV>
 <898afc09-428f-4da2-a620-d7ca9f37133c@kernel.dk>
 <20240415210827.GX2118490@ZenIV>
 <de942b9c-6e91-4dcc-a386-9d1317e0e0b4@kernel.dk>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <de942b9c-6e91-4dcc-a386-9d1317e0e0b4@kernel.dk>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Mon, Apr 15, 2024 at 03:16:12PM -0600, Jens Axboe wrote:

> The old read/write path only handled user pointers, with the exception
> being bvecs mapped on the io_uring side (which the io_uring version
> dealt with) which also originally came from user pointers. So just user
> memory. Why would we need to expand that now? Who would be doing
> ->read_iter() or ->write_iter() with something that isn't either UBUF or
> IOVEC? Because that would break horrible as it is in the current kernel.

No, it will not.  And yes, it does happen.  Look, for example, at
fs/coredump.c:dump_emit_page().  ->write_iter() (regular file or pipe one)
is called.  On ITER_BVEC.

It happens, and not only there.  Look at how /dev/loop works, for crying
out loud!  You get a struct request; the backing pages might very well have
_never_ been mapped to any userland address (e.g. when it's something like
a directory block).  And you hit this:

static int lo_write_simple(struct loop_device *lo, struct request *rq,
                loff_t pos)
{
        struct bio_vec bvec;
        struct req_iterator iter;
        int ret = 0;

        rq_for_each_segment(bvec, rq, iter) {
                ret = lo_write_bvec(lo->lo_backing_file, &bvec, &pos);
                if (ret < 0)
                        break;
                cond_resched();
        }

        return ret;
}

with lo_write_bvec() being

static int lo_write_bvec(struct file *file, struct bio_vec *bvec, loff_t *ppos)
{
        struct iov_iter i;
        ssize_t bw;

        iov_iter_bvec(&i, ITER_SOURCE, bvec, 1, bvec->bv_len);

        bw = vfs_iter_write(file, &i, ppos, 0);

        if (likely(bw ==  bvec->bv_len))
                return 0;   

        printk_ratelimited(KERN_ERR
                "loop: Write error at byte offset %llu, length %i.\n",
                (unsigned long long)*ppos, bvec->bv_len);
        if (bw >= 0)
                bw = -EIO;
        return bw;
}


Neither ->read_iter() nor ->write_iter() can make an assumption that it
will be used with userland buffer.  And yes, it works...

