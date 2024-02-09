Return-Path: <linux-kernel+bounces-59221-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AFA7484F366
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 11:28:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3F4B3B29D6D
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 10:28:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1052969949;
	Fri,  9 Feb 2024 10:28:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="k+bUiP7H"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 590D1692F3
	for <linux-kernel@vger.kernel.org>; Fri,  9 Feb 2024 10:27:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707474479; cv=none; b=iOX8j6oNbsGbyJbgpfVNd6HHkaZ9FsI44MsjcIjWS90r0M6h7KxQSPF2tOzSYoTy+LvwrTS/bXD58tcVBHNnWrKQsSGwafQd7BwV9/XNij2mP5yn4JoPm2jK/xQHMroAyoE2tkvh09/3GTuPRcZEsnLQyoOEDvJIv4IYDtHTBnw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707474479; c=relaxed/simple;
	bh=NlVQDdTOWwrDfzKJppZPuesKWrZtqMTgmzG/wN9cAQQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IiQ3ZwKOrN9b4uE5VhRKhtdb4TH/00vpkOJ9lWpXVm91PHIRrA/FWGToqAAQHjBnF/2/UDu6yJsqLUQBmCPIIoUyFUx/UdISfGaIPyLyWpQxkFH3LYSEBJP82liUxxgl6dRLj5Xvws/fYOzefy2n8yfF3KVbd39qgDRmzxEovp0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=k+bUiP7H; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A607C433F1;
	Fri,  9 Feb 2024 10:27:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1707474478;
	bh=NlVQDdTOWwrDfzKJppZPuesKWrZtqMTgmzG/wN9cAQQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=k+bUiP7HvAjooPbaqPVagxYSceYRe40xQolaIKhIE+lN7CvEIJPLfvlrTk73C1qe3
	 IYZuQbr27GVqLrs7wvme1qH+Od59N+Y8oZ1OjQ1CGB3qovX4NGZKMdyZFJvJ4fK4Nn
	 ARk3heHJmAawVwWjJ0i+dDvKc0uIcsMAjcf8f+pg=
Date: Fri, 9 Feb 2024 10:27:56 +0000
From: Greg KH <gregkh@linuxfoundation.org>
To: Rohan Kollambalath <rohankollambalath@gmail.com>
Cc: linux-kernel@vger.kernel.org, Rohan Kollambalath <rkollamb@digi.com>
Subject: Re: [PATCH] sysfs:Addresses null pointer dereference in
 sysfs_merge_group and sysfs_unmerge_group.
Message-ID: <2024020946-reexamine-unwitting-6277@gregkh>
References: <20240208233626.657587-1-rohankollambalath@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240208233626.657587-1-rohankollambalath@gmail.com>

On Fri, Feb 09, 2024 at 09:36:26AM +1000, Rohan Kollambalath wrote:
> From: Rohan Kollambalath <rkollamb@digi.com>
> 
> These functions take a struct attribute_group as an input which has an
> optional .name field. These functions rely on the .name field being
> populated and do not check if its null. They pass this name into other
> functions, eventually leading to a null pointer dereference.

What in-kernel drivers cause this to trigger?  Why not fix them up
instead?

> This change adds a simple check that returns an error if the .name field
> is null and clarifies this requirement in the comments.
> 
> Signed-off-by: Rohan Kollambalath <rkollamb@digi.com>
> ---
>  fs/sysfs/group.c | 14 ++++++++++----
>  1 file changed, 10 insertions(+), 4 deletions(-)
> 
> diff --git a/fs/sysfs/group.c b/fs/sysfs/group.c
> index 138676463336..a221de8c95a2 100644
> --- a/fs/sysfs/group.c
> +++ b/fs/sysfs/group.c
> @@ -318,12 +318,12 @@ void sysfs_remove_groups(struct kobject *kobj,
>  EXPORT_SYMBOL_GPL(sysfs_remove_groups);
>  
>  /**
> - * sysfs_merge_group - merge files into a pre-existing attribute group.
> + * sysfs_merge_group - merge files into a pre-existing named attribute group.
>   * @kobj:	The kobject containing the group.
>   * @grp:	The files to create and the attribute group they belong to.
>   *
> - * This function returns an error if the group doesn't exist or any of the
> - * files already exist in that group, in which case none of the new files
> + * This function returns an error if the group doesn't exist, the .name field is NULL or
> + * any of the files already exist in that group, in which case none of the new files

Please properly wrap comments at the correct column.

>   * are created.
>   */
>  int sysfs_merge_group(struct kobject *kobj,
> @@ -336,6 +336,9 @@ int sysfs_merge_group(struct kobject *kobj,
>  	struct attribute *const *attr;
>  	int i;
>  
> +	if (!grp->name)
> +		return -ENOENT;

Why that error value?


> +
>  	parent = kernfs_find_and_get(kobj->sd, grp->name);
>  	if (!parent)
>  		return -ENOENT;
> @@ -356,7 +359,7 @@ int sysfs_merge_group(struct kobject *kobj,
>  EXPORT_SYMBOL_GPL(sysfs_merge_group);
>  
>  /**
> - * sysfs_unmerge_group - remove files from a pre-existing attribute group.
> + * sysfs_unmerge_group - remove files from a pre-existing named attribute group.
>   * @kobj:	The kobject containing the group.
>   * @grp:	The files to remove and the attribute group they belong to.
>   */
> @@ -366,6 +369,9 @@ void sysfs_unmerge_group(struct kobject *kobj,
>  	struct kernfs_node *parent;
>  	struct attribute *const *attr;
>  
> +	if (!grp->name)
> +		return -ENOENT;

Again, why that value?

And again, why not fix up the callers?

thanks,

greg k-h

